class Operation < ApplicationRecord
  belongs_to :sleep

  enum operation_type: { stop: 0, start: 1 }
end
