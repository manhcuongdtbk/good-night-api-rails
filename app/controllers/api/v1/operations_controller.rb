module Api
  module V1
    class OperationsController < ApplicationController
      def create
        operation = Operation.create!(operation_params)
        json_response_object(operation, :created)
      end

      private

      def operation_params
        params.permit(:operation_type, :operated_at).merge(user_id: params[:user_id])
      end
    end
  end
end
