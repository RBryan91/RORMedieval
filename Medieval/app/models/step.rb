class Step < ApplicationRecord
  belongs_to :quest
  belongs_to :monster, optional: true
  belongs_to :enigme, optional: true
  belongs_to :player, optional: true
end
