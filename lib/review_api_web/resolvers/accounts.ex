defmodule ReviewApiWeb.Resolvers.Accounts do
  alias ReviewApi.Accounts
  alias ReviewApiWeb.Schema.ChangesetErrors

  def list_organizations(_, _, _) do
    {:ok, Accounts.list_organizations()}
  end

  def get_organization(%{id: id}, _) do
    {:ok, Accounts.get_organization!(id)}
  end

  def list_users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  def create_organization(_, %{input_data: args}, _) do
    case Accounts.create_organization(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create organization",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, organization} ->
        {:ok, %{result: organization}}
    end
  end

  def signin(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      :error ->
        {:error, "Invalid credentials!"}

      {:ok, user} ->
        token = ReviewApiWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def signup(_, %{input: input}, _) do
    case Accounts.create_user(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not signup user", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        {:ok, user}
    end
  end
end
