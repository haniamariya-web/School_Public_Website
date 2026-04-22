module ImageHelper
  def gallery_image(object, size: [800, 600])
    image = if object.respond_to?(:cover_image) && object.cover_image.attached?
              object.cover_image
            elsif object.respond_to?(:image) && object.image.attached?
              object.image
            end

    return nil unless image

    image.variant(resize_to_fill: size).processed
  end
end