module Response
  def json_response_object(object, status = :ok)
    render json: object, status: status
  end

  def json_response_message(message, status = :ok)
    render json: { message: message }, status: status
  end
end
