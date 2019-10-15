defmodule ReviewApiWeb.Resolvers.User do
  alias ReviewApi.Accounts
  alias ReviewApiWeb.Schema.ChangesetErrors

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
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

  @spec signup(
          any,
          %{input: :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}},
          any
        ) :: {:error, [{:details, map} | {:message, <<_::168>>}, ...]} | {:ok, any}
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
