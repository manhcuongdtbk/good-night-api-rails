class CreateOperationsIndexJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    operations = Operation.where(user_id: user_id).order(created_at: :desc)

    Rails.cache.fetch(Operation.index_cache_key(operations)) do
      operations.as_json(only: [:id, :operation_type, :operated_at, :created_at])
    end
  end
end
