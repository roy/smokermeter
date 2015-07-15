class BaseSerializer < ActiveModel::Serializer

  def attributes(*args)
    data = super(*args)

    if current_user.admin?
      data.merge! timestamps

      if respond_to?(:attributes_for_admin)
        data.merge! attributes_for_admin
      end
    end

    data
  end

  def timestamps
    {
      created_at: object.created_at,
      updated_at: object.updated_at,
    }
  end
end
