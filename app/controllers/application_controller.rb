class ApplicationController < ActionController::Base
  # Add this line to see the progress bar long enough
  # and remove it when it has the expected styles
  # before_action -> { sleep 3 }
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end
  
  # Now that we have our current_company helper, 
  # we can use it in our views and especially in our navbar:
  helper_method :current_company
end
