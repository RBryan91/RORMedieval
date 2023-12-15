class Monster < ApplicationRecord
  belongs_to :item, optional: true

  has_many :steps

  validates :name, presence: true
  validates :pv, presence: true
  validates :force, presence: true
  validates :rate, presence: true, if: :item_id_present?
  validates :avatar, presence: true

  def set_full_path_for_avatar(filename)
    self.avatar = File.join('avatar/monster', filename)
  end

  def item_id_present?
    item_id.present?
  end

end
