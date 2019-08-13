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

  input_object :user_input do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
    field(:organization_id, non_null(:id))
  end
end
