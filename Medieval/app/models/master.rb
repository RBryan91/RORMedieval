class Master < ApplicationRecord
    has_many :quests
    validates :username, presence: true
    validates :password, presence: true, length: { minimum: 8 }
end
