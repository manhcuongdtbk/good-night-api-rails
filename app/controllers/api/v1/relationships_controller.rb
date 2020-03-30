module Api
  module V1
    class RelationshipsController < ApplicationController
      def create
        followed_user = User.find(params[:followed_id])
        user.follow(followed_user)
        json_response_message(I18n.t("controllers.relationships.create.follow_successfully",
                                     followed_id: params[:followed_id]))
      end

      def destroy
        followed_user = Relationship.find_by!(follower_id: params[:user_id], followed_id: params[:followed_id]).followed
        user.unfollow(followed_user)
        json_response_message(I18n.t("controllers.relationships.destroy.unfollow_successfully",
                                     followed_id: params[:followed_id]))
      end

      private

      def user
        @user ||= User.find(params[:user_id])
      end
    end
  end
end
