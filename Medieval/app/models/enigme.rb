class Enigme < ApplicationRecord
    has_many :answers
    has_many :steps

    validates :titre, presence: true
end
