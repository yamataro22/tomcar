class Category < ApplicationRecord
  has_many :subcategories, foreign_key: "category_id", dependent: :destroy
  accepts_nested_attributes_for :subcategories, update_only: true, allow_destroy: true

  validates :name, presence: true, length: {maximum: 20}
end
