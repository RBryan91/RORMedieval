class Step < ApplicationRecord
  belongs_to :quest
  belongs_to :monster, optional: true
  belongs_to :enigme, optional: true
  belongs_to :character, optional: true

  validates :titre, presence: true
  validates :xp, presence: true, numericality: { greater_than: 0 }
  validates :quest_id, presence: true
end
