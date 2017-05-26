class Category < ApplicationRecord
  has_many :groups, dependent: :destroy, foreign_key: :category_id
end
