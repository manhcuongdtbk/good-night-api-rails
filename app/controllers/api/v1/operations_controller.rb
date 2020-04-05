module Api
  module V1
    class OperationsController < ApplicationController
      def index
        user = User.select(:id, :name).find(params[:user_id])
        operations = user.operations.select(:id, :operation_type, :operated_at, :created_at).order(created_at: :desc)

        cached_operations = Rails.cache.fetch(Operation.index_cache_key(operations)) do
          operations.to_json
        end

        json_response_object(cached_operations)
      end

      def create
        operation = Operation.create!(operation_params)
        json_response_object(operation, :created)
      end

      private

      def operation_params
        params.permit(:operation_type, :operated_at, :user_id)
      end
    end
  end
end
