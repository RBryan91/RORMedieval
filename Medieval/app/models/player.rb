class Player < ApplicationRecord
    has_secure_password
    has_many :hdvs
    has_many :inventorys
    has_many :quests
    has_many :steps
    validates :name, presence: true
    validates :password, presence: true
end
