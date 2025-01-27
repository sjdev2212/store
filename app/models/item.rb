class Item < ApplicationRecord
  has_many_attached :images

  validate :image_count_within_limit

  def as_json(options = {})
  super(options.merge({
                        methods: [:image_urls]
                      }))
end

def image_urls
  images.map { |image| Cloudinary::Utils.cloudinary_url(image.key) } if images.attached?
end
  private

  def image_count_within_limit
    errors.add(:images, "You can upload a maximum of 5 images.") if images.count > 5
  end
end
