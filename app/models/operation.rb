class Operation < ApplicationRecord
  validates :operated_at, presence: true
end
