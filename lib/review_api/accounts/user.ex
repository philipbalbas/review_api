defmodule ReviewApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :exam_batch, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :role, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :exam_batch, :email, :password_hash, :role])
    |> validate_required([:first_name, :last_name, :username, :exam_batch, :email, :password_hash, :role])
  end
end
