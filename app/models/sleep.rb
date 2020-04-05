class Sleep < ApplicationRecord
  has_one :operation_start, -> { where operation_type: "start" }, class_name: "Operation", dependent: :destroy,
                                                                  inverse_of: :sleep
  has_one :operation_stop, -> { where operation_type: "stop" }, class_name: "Operation", dependent: :destroy,
                                                                inverse_of: :sleep
  belongs_to :user

  class << self
    def following_sleeps(following_ids)
      select(:id, :duration, :user_id).includes(:operation_start, :operation_stop)
                                      .where(user_id: following_ids)
                                      .where("duration > 0 AND created_at >= ?", 1.week.ago)
                                      .order(user_id: :desc, duration: :desc)
    end
  end
end
