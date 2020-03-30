class Operation < ApplicationRecord
  belongs_to :sleep

  enum operation_type: { start: 0, stop: 1 }

  validates :operation_type, presence: true
  validates :operated_at, presence: true
end
