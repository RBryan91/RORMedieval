class Monster < ApplicationRecord
  belongs_to :item, optional: true

  has_many :steps

  validates :name, presence: true
  validates :pv, presence: true
  validates :force, presence: true
  validates :rate, presence: true, if: :item_id_present?
  validates :avatar, presence: true
  validate :set_full_path_for_avatar, on: :create


  def set_full_path_for_avatar
    self.avatar = File.join('avatar/monster', avatar) unless avatar.blank?
  end

  def item_id_present?
    item_id.present?
  end

end
