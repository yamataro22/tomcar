class Product < ApplicationRecord
    validates :name,              presence: true, 
                                  length: { maximum: 20 }
    validates :short_description, presence: true, 
                                  length: { maximum: 120 }
end
