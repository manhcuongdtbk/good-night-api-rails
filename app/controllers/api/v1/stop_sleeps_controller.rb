module Api
  module V1
    class StopSleepsController < ApplicationController
      def create
        user = User.find(params[:user_id])
        user.stop_sleeps.create!(stop_sleeps_params)
        json_response_message(I18n.t("controllers.stop_sleeps.create.clocked_in_successfully"))
      end

      private

      def stop_sleeps_params
        params.permit(:started_at, :stopped_at)
      end
    end
  end
end
