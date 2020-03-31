class Operation < ApplicationRecord
  belongs_to :sleep
  validates :operated_at, presence: true
  before_validation :start_stop_cycle

  enum operation_type: { stop: 0, start: 1 }

  def initialize(params)
    @user_id = params[:user_id] if params[:user_id].present?
    params.delete(:user_id)
    super(params)
  end

  private

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  def start_stop_cycle
    last_sleep = Sleep.where(user_id: @user_id).last

    if last_sleep
      last_operation = Operation.where(sleep_id: last_sleep.id).last

      if last_operation.operation_type == "start" && operation_type == "stop"
        self.sleep = last_sleep
      elsif last_operation.operation_type == "stop" && operation_type == "start"
        build_sleep(user_id: @user_id)
      else
        errors.add(:operation_type, :invalid)
      end
    else
      operation_type == "start" ? build_sleep(user_id: @user_id) : errors.add(:operation_type, :invalid)
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
end
