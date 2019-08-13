defmodule ReviewApiWeb.Resolvers.User do
  alias ReviewApi.Accounts
  alias ReviewApiWeb.Schema.ChangesetErrors

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
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
