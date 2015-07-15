class BarbecueAuthorizer < BaseAuthorizer

  attr_reader :model

  def initialize(user, model)
    super(user)
    @model = model
  end

  protected
  def is_owner?
    user.id == model.user_id
  end
end
