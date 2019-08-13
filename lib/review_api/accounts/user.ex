defmodule ReviewApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Accounts.Organization

  schema "users" do
    field :email, :string
    field :exam_batch, :string
    field :first_name, :string
    field :last_name, :string
    field(:role, :string, default: "student")
    field :username, :string
    field :password_hash, :string
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    belongs_to(:organization, Organization)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :first_name,
      :last_name,
      :username,
      :exam_batch,
      :email,
      :password,
      :password_confirmation,
      :role
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    ])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hash_password(changeset) do
    changeset
  end
end
