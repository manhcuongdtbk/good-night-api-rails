class Sleep < ApplicationRecord
  belongs_to :user
  belongs_to :operation_start, class_name: "Operation", foreign_key: "operation_start_id"
  belongs_to :operation_stop, class_name: "Operation", foreign_key: "operation_stop_id", optional: true
end
