defmodule ReviewApiWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:organization_id, :id)
    field(:role, :string)
  end
end
