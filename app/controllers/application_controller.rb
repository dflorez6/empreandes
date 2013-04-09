class ApplicationController < ActionController::Base
  protect_from_forgery
  include StaticsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request

    super
  end
end
