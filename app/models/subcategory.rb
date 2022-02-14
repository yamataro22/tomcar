class Subcategory < ApplicationRecord
    belongs_to :category, class_name: "Category"
    validates :name, presence: true, length: {maximum: 20}
end
