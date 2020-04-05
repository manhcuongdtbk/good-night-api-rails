class CreateOperationsIndexJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*args)
    user_id = *args
    operations = Operation.select(:id, :operation_type, :operated_at, :created_at).where(user_id: user_id)
                          .order(created_at: :desc)

    Rails.cache.fetch(Operation.index_cache_key(operations)) do
      operations.to_json
    end
  end
end
