defmodule ReviewApiWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  node object(:user) do
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:organization_id, :id)
    field(:role, :string)
  end

  node object(:session) do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end

  input_object :user_input do
    field(:username, non_null(:string))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:organization_id, non_null(:id))
  end
end
