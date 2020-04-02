module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response_message(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response_message(e.message, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      json_response_message(e.message, :conflict)
    end
  end
end
