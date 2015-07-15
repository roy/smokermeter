class BarbecueSerializer < BaseSerializer
  attributes :id, :name

  belongs_to :user
end
