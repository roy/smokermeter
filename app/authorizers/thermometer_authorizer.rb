class ThermometerAuthorizer < BaseAuthorizer

  attr_reader :barbecue, :thermometer

  def initialize(user, barbecue, thermometer)
    super(user)
    @barbecue, @thermometer = barbecue, thermometer
  end

  protected
  def is_owner?
    user.id == barbecue.user_id && thermometer.barbecue_id == barbecue.id
  end
end
