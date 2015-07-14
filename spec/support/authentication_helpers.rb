module AuthenticationHelpers
  def sign_in(user)
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.email,user.password)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end
