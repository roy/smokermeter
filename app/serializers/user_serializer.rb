class UserSerializer < BaseSerializer
  attributes :id, :name, :email

  def attributes_for_admin
    { is_admin: object.is_admin == true }
  end
end
