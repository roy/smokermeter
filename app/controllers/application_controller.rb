class ApplicationController < ActionController::Base
  class UnAuthorizedError < StandardError; end

  rescue_from UnAuthorizedError, with: :deny_access

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def default_serializer_options  
    {root: false}  
  end  

  def current_user
    @current_user ||= find_by_http_auth || GuestUser.new
  end
  helper_method :current_user

  def authorize
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by(email: email)
      return false unless user

      user.authenticate(password)
    end
  end

  def deny_access
    render json: ['Unauthorized'], status: 401
  end

  private

  def find_by_http_auth
    return nil if request.authorization.nil?

    email, password = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    user = User.find_by(email: email)
    return nil unless user

    user.authenticate(password)
  end
end
