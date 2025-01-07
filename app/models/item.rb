class Item < ApplicationRecord
  has_one_attached :image

  def as_json(options = {})
    super(options.merge({
                          methods: [:image_url]
                        }))
  end

  def image_url
    return unless image.attached?

    # Use the Cloudinary service URL
    Cloudinary::Utils.cloudinary_url(image.key, secure: true)
  end
end
