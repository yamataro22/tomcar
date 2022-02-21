class Product < ApplicationRecord
    belongs_to :subcategory, class_name: "Subcategory"
    has_one_attached :image
    validates :name,              presence: true, 
                                  length: { maximum: 20 }
    validates :short_description, presence: true, 
                                  length: { maximum: 120 }
    validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "Nieprawidłowy format pliku" }

    def display_image(size = [400,400])
        image.variant(resize_to_limit: size)
    end

end
