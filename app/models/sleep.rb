class Sleep < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validates :clock_in_created_at, presence: true
end
