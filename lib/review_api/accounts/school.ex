defmodule ReviewApi.Accounts.School do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Accounts.School

  schema "schools" do
    field :city, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :street, :string

    has_many(:users, School)

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :street, :city, :email, :phone])
    |> validate_required([:name, :street, :city, :email, :phone])
    |> unique_constraint(:name)
  end
end
