class BarbecueAuthorizer

  attr_reader :user, :model

  def initialize(user, model)
    @user, @model = user, model
  end

  def show?
    true
  end

  def update?
    return true if user.admin?
    return true if user.id == model.user_id

    false
  end
  alias_method :destroy?, :update?

end
