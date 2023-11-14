class Item < ApplicationRecord
    has_many :hdvs
    has_many :inventorys
    has_many :monsters
    has_many :quests
end
