defmodule ReviewApiWeb.Schema.Types.OrganizationType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  # enum :organization_role do
  #   value(:school)
  #   value(:company)
  #   value(:organization)
  # end

  node object(:organization) do
    field(:name, :string)
    field(:email, :string)
    field(:street, :string)
    field(:city, :string)
    field(:role, :string)
  end
end
