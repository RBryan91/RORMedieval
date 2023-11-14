class Player < ApplicationRecord
    has_many :hdvs
    has_many :inventorys
    has_many :quests
    has_many :steps
end
