class Sleep < ApplicationRecord
  belongs_to :user

  validates :started_at, presence: true
end
