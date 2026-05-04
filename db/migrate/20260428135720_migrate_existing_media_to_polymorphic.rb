class MigrateExistingMediaToPolymorphic < ActiveRecord::Migration[8.1]
  def up
    # Direct database query to find all old attachments for News and Post
    # This works regardless of what is written in your .rb model files
    ActiveStorage::Attachment.where(record_type: [ 'News', 'Post' ]).find_each do |attr|
      parent = attr.record

      # Safety check: skip if the parent record was deleted or already has a media_file
      next if parent.nil?
      next if parent.respond_to?(:media_file) && parent.media_file.present?

      # Create the new polymorphic link using the existing blob
      parent.create_media_file!(file: attr.blob)

      puts "Migrated #{attr.record_type} ID #{attr.record_id}: [#{attr.name}] -> MediaFile"
    end
  end

  def down
    # Removes the MediaFile links but keeps the actual files safe
    MediaFile.where(mediable_type: [ 'News', 'Post' ]).destroy_all
  end
end
