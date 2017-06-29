class Menu < ApplicationRecord
  belongs_to :place

  has_one :picture, as: :imageable
end
