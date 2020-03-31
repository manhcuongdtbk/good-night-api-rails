module Api
  module V1
    class StartSleepsController < ApplicationController
      def create
        user = User.find(params[:user_id])
        user.start_sleeps.create!(start_sleep_params)
        json_response_message(I18n.t("controllers.start_sleeps.create.clocked_in_successfully"))
      end

      private

      def start_sleep_params
        params.permit(:started_at)
      end
    end
  end
end
