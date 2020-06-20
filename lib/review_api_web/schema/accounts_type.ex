defmodule ReviewApiWeb.Schema.Types.AccountsType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  enum :organization_role do
    value(:school, as: "school")
    value(:company, as: "company")
    value(:organization, as: "organization")
  end

  enum :user_role do
    value(:student, as: "student")
    value(:teacher, as: "teacher")
    value(:admin, as: "admin")
  end

  node object(:session) do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end

  node object(:user) do
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:organization_id, :id)
    field(:role, :string)
  end

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

  input_object :user_signup_input do
    field(:username, :string)
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:organization_id, non_null(:id))
    field(:role, :user_role)
  end
end
