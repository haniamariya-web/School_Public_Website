class MediaFile < ApplicationRecord
  belongs_to :mediable, polymorphic: true
  has_one_attached :file

  MAX_SIZE = 10.megabytes

  validates :file, presence: true
  validate :validate_file_type
  validate :validate_file_size

  private

  def validate_file_type
    return unless file.attached?
    unless file.content_type.start_with?('image/', 'video/')
      errors.add(:file, "must be an image or video")
    end
  end

  def validate_file_size
    return unless file.attached?
    if file.blob.byte_size > MAX_SIZE
      errors.add(:file, "must be smaller than #{MAX_SIZE / 1.megabyte} MB")
    end
  end
end