class BaseAuthorizer

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def show?
    true
  end

  def update?
    return true if is_admin?
    return true if is_owner?

    false
  end
  alias_method :destroy?, :update?

  protected 
  def is_admin?
    user.admin?
  end
end
