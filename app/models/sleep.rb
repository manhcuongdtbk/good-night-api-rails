class Sleep < ApplicationRecord
  has_one :operation_start, -> { where operation_type: "start" }, class_name: "Operation", dependent: :destroy
  has_one :operation_stop, -> { where operation_type: "stop" }, class_name: "Operation", dependent: :destroy
  belongs_to :user
end
