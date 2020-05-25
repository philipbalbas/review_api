defmodule ReviewApiWeb.Schema.Types.AccountsType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  enum :organization_role do
    value(:school, as: "school")
    value(:company, as: "company")
    value(:organization, as: "organization")
  end

  # connection(node_type: :organization)

  node object(:organization) do
    field(:name, :string)
    field(:email, :string)
    field(:street, :string)
    field(:city, :string)
    field(:role, :organization_role)
  end

  input_object :organization_input do
    field(:name, non_null(:string))
    field(:city, :string)
    field(:email, :string)
    field(:street, :string)
    field(:role, :organization_role)
  end
end
