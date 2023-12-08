class Answer < ApplicationRecord
  belongs_to :enigme

  validates :enigme_id, presence: true
  validates :true, presence: true
  validates :reponse_1, presence: true
  validates :reponse_2, presence: true
  validates :reponse_3, presence: true

end
