class ThermometerAuthorizer
  attr_reader :user, :barbecue, :thermometer

  def initialize(user, barbecue, thermometer)
    @user, @barbecue, @thermometer = user, barbecue, thermometer
  end

  def update?
    return true if is_admin?
    return true if is_owner?

    false
  end
  alias_method :destroy?, :update?

  private
  def is_admin?
    user.admin?
  end

  def is_owner?
    user.id == barbecue.user_id && thermometer.barbecue_id == barbecue.id
  end
end
