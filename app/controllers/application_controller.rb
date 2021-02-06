class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_team

  private

  def current_team
    current_user.team
  end
end
