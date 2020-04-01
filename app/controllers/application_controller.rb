class ApplicationController < ActionController::API
  include AbstractController::Translation
  include Response
  include ExceptionHandler
end
