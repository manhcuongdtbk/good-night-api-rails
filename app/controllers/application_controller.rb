class ApplicationController < ActionController::API
  include ActionController::Caching
  include AbstractController::Translation
  include Response
  include ExceptionHandler
end
