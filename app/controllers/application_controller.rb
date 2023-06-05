class ApplicationController < ActionController::Base

  add_flash_types :error, :success
  rescue_from ActiveRecord::RecordNotFound, with: -> { redirect_to '/404.html' }

end
