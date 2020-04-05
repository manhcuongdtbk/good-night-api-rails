class UserFollowingSleepsService
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def perform
    following_ids = user.following_ids.reverse
    original_sleeps = Sleep.following_sleeps(following_ids)

    following_sleeps_json(following_ids, original_sleeps).to_json
  end

  private

  attr_reader :user

  def following_sleeps_json(following_ids, original_sleeps)
    following_ids.map do |following_id|
      current_sleeps = original_sleeps.select { |original_sleep| original_sleep.user_id == following_id }

      sleeps = current_sleeps.map do |sleep|
        {
          id: sleep.id,
          duration: sleep.duration,
          started_at: sleep.operation_start.operated_at,
          stopped_at: sleep.operation_stop.operated_at
        }
      end

      { user_id: following_id, sleeps: sleeps }
    end
  end
end
