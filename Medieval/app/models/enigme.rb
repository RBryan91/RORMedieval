class Enigme < ApplicationRecord
    has_many :answers
    has_many :steps
end
