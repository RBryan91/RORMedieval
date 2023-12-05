class Player < ApplicationRecord
    has_secure_password
    has_many :characters
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 8 }
end
