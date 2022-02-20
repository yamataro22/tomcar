class Product < ApplicationRecord
    belongs_to :subcategory, class_name: "Subcategory"
    validates :name,              presence: true, 
                                  length: { maximum: 20 }
    validates :short_description, presence: true, 
                                  length: { maximum: 120 }

end
