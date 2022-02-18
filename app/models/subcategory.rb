class Subcategory < ApplicationRecord
    has_many   :products, foreign_key: "subcategory_id", dependent: :destroy
    belongs_to :category, class_name: "Category"
    validates  :name,     presence: true, length: {maximum: 20}
end
