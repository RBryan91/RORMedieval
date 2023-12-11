class Hdv < ApplicationRecord
  belongs_to :item
  belongs_to :character

  validates :item_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :character_id, presence: true
end
