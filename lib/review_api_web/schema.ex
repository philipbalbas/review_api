defmodule ReviewApiWeb.Schema do
  use Absinthe.Schema
  alias ReviewApiWeb.Resolvers
  import_types(ReviewApiWeb.Schema.Types)

  query do
    @desc "Get a list of organizations"
    field :organizations, list_of(:organization) do
      resolve(&Resolvers.Organization.organizations/3)
    end

    @desc "Get an organization"
    field :organization, :organization do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Organization.organization/3)
    end

    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve(&Resolvers.User.users/3)
    end

    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.User.user/3)
    end
  end

  mutation do
    @desc "Create an organization"
    field :create_organization, :organization do
      arg(:city, :string)
      arg(:email, :string)
      arg(:name, non_null(:string))
      arg(:phone, :string)
      arg(:street, :string)
      arg(:role, non_null(:string))
      resolve(&Resolvers.Organization.create_organization/3)
    end
  end
end
