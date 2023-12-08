class Inventory < ApplicationRecord
  belongs_to :character
  belongs_to :item

  validates :item_id, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates :character_id, presence: true
end
