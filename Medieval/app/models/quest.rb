class Quest < ApplicationRecord
  belongs_to :item
  belongs_to :character, optional: true
  belongs_to :master

  has_many :steps
  has_many :characters

  validates :title, presence: true
  validates :xp, presence: true
  validates :item_id, presence: true
  validates :master_id, presence: true

end
