class Quest < ApplicationRecord
  belongs_to :item
  belongs_to :character, optional: true
  belongs_to :master

  has_many :steps
  has_many :characters

  validates :title, presence: true
  validates :xp, presence: true, numericality: { greater_than: 0 }
  validates :item_id, presence: true
  validates :master_id, presence: true
  validates :po, presence: true, numericality: { greater_than: 0 }


end
