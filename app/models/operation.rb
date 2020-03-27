class Operation < ApplicationRecord
  belongs_to :sleep

  validates :operation_type, presence: true
  validates :operated_at, presence: true
  validates :sleep_id, presence: true

  enum operation_type: { start: 0, stop: 1 }
end
