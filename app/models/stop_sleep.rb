class StopSleep < Sleep
  validates :stopped_at, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }

  after_initialize :assign_duration

  private

  def assign_duration
    return if started_at.blank? || stopped_at.blank?

    self.duration = stopped_at - started_at
  end
end
