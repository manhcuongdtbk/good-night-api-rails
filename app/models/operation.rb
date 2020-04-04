class Operation < ApplicationRecord
  belongs_to :sleep
  belongs_to :user

  enum operation_type: { stop: 0, start: 1 }

  before_validation :start_stop_cycle, on: :create, if: -> { user_id.present? }
  validates :operated_at, presence: true
  validate :operated_at_in_valid_range, if: -> { operated_at.present? }
  after_create :update_sleep_duration, if: -> { operation_type == "stop" }
  after_save :create_index_json_cache

  class << self
    def index_cache_key(operations)
      operations.maximum(:updated_at)
    end
  end

  private

  attr_reader :last_operation

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  def start_stop_cycle
    return errors.add(:sleep_id, :redundant) if sleep.present? || sleep_id.present?

    last_sleep = Sleep.where(user_id: user_id).last

    if last_sleep
      @last_operation = Operation.where(sleep_id: last_sleep.id).last

      if last_operation.operation_type == "start" && operation_type == "stop"
        self.sleep = last_sleep
      elsif last_operation.operation_type == "stop" && operation_type == "start"
        build_sleep(user_id: user_id)
      else
        errors.add(:operation_type, :invalid)
      end
    else
      operation_type == "start" ? build_sleep(user_id: user_id) : errors.add(:operation_type, :invalid)
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def operated_at_in_valid_range
    return if operated_at <= Time.zone.now && (!last_operation || operated_at > last_operation.operated_at)

    errors.add(:operated_at, :invalid)
  end

  def update_sleep_duration
    self.sleep.update!(duration: operated_at - last_operation.operated_at)
  end

  def create_index_json_cache
    CreateOperationsIndexJsonCacheJob.perform_later(user_id)
  end
end
