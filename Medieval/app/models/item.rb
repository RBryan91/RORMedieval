class Item < ApplicationRecord
    has_many :hdvs
    has_many :inventorys
    has_many :monsters
    has_many :quests

    validates :name, presence: true
    validates :category, inclusion: { in: %w(Arme Casque Bouclier) }
    validates :xp, presence: true
    validates :force, presence: true
    validates :pv, presence: true
end
