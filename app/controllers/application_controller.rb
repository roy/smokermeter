class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def default_serializer_options  
    {root: false}  
  end  

  def current_user
    @current_user ||= find_by_http_auth
  end

  def find_by_http_auth
    return nil if request.authorization.nil?

    email, password = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    user = User.find_by(email: email)
    return nil unless user

    user.authenticate(password)
  end

  def authorize
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by(email: email)
      return false unless user

      user.authenticate(password)
    end
  end
end
