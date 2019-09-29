defmodule ReviewApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Accounts.Organization

  schema "users" do
    field :email, :string
    field :exam_batch, :string
    field :first_name, :string
    field :last_name, :string
    field :role, :string, default: "student"
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    belongs_to :organization, Organization

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    required_fields = [
      :username,
      :email,
      :password,
      :organization_id
    ]

    optional_fields = [
      :first_name,
      :last_name,
      :exam_batch,
      :role
    ]

    user
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:organization)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:username, min: 2, max: 100)
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
