class Step < ApplicationRecord
  belongs_to :quest
  belongs_to :monster, optional: true
  belongs_to :enigme, optional: true
  belongs_to :character, optional: true

  validates :titre, presence: true
  validates :xp, presence: true, numericality: { greater_than: 0 }
  validates :quest_id, presence: true
  validates :po, presence: true, numericality: { greater_than: 0 }

  validate :validate_monster_or_enigme_presence

  private

  def validate_monster_or_enigme_presence
    if monster_id.blank? && enigme_id.blank?
      errors.add(:base, "Step must have either monster_id or enigme_id")
    elsif monster_id.present? && enigme_id.present?
      errors.add(:base, "Step cannot have both monster_id and enigme_id")
    end
  end
end
