module ImageHelper
  def gallery_image(object, size: [800, 600])
    image = if object.respond_to?(:cover_image) && object.cover_image.attached?
              object.cover_image
            elsif object.respond_to?(:image) && object.image.attached?
              object.image
            elsif object.respond_to?(:media_file) && object.media_file&.file&.attached? && object.media_file.file.content_type.start_with?('image/')
              object.media_file.file
            end

    return nil unless image

    image.variant(resize_to_fill: size).processed
  end
end