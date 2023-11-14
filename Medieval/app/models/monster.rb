class Monster < ApplicationRecord
  belongs_to :item

  has_many :steps
end
