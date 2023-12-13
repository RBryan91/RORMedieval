class Character < ApplicationRecord
  belongs_to :player
  belongs_to :quest, optional: true

  has_many :inventorys
  has_many :hdvs
  has_many :quests
  has_many :steps
  
  validates :name, presence: true
  validates :force, presence: true
  validates :pv, presence: true
  validates :po, presence: true
  validates :level, presence: true
  validates :xp, presence: true
  validates :player_id, presence: true
  validate :total_points_within_limit

  def total_points_within_limit
    total_points = force.to_i + pv.to_i
    errors.add(:base, 'Total points cannot exceed 30') if total_points > 30
    errors.add(:base, 'Total points must be 30') if total_points < 30
  end

end
