module Api
  module V1
    class FollowingSleepsController < ApplicationController
      def index
        following_sleeps = UserFollowingSleepsService.new(params[:user_id]).perform
        json_response_object(following_sleeps)
      end
    end
  end
end
