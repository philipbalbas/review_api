defmodule ReviewApiWeb.Schema.Types.OrganizationType do
  use Absinthe.Schema.Notation

  # enum :organization_role do
  #   value(:school)
  #   value(:company)
  #   value(:organization)
  # end

  object :organization do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:street, :string)
    field(:city, :string)
    field(:role, :string)
  end
end
