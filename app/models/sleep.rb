class Sleep < ApplicationRecord
  has_many :operations, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
end
