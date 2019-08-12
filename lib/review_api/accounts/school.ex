defmodule ReviewApi.Accounts.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schools" do
    field :city, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :street, :string

    

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :street, :city, :email, :phone])
    |> validate_required([:name, :street, :city, :email, :phone])
  end
end
