class Quest < ApplicationRecord
  belongs_to :item
  belongs_to :player, optional: true
  belongs_to :master

  has_many :steps

  validates :title, presence: true
  validates :xp, presence: true
  validates :item_id, presence: true
  validates :master_id, presence: true

end
