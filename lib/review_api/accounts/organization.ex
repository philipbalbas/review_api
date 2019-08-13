defmodule ReviewApi.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Accounts.User

  schema "organizations" do
    field :city, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :street, :string
    field :role, :string

    has_many(:users, User)

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :street, :city, :email, :phone, :role])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
