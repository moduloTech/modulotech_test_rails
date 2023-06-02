class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: -> { redirect_to '/404.html' }
end
