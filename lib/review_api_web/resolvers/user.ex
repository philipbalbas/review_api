defmodule ReviewApiWeb.Resolvers.User do
  alias ReviewApi.Accounts
  alias ReviewApiWeb.Schema.ChangesetErrors

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  # def organization(_, %{id: id}, _) do
  #   {:ok, Accounts.get_organization!(id)}
  # end

  # @spec create_organization(
  #         any,
  #         :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any},
  #         any
  #       ) :: {:error, [{:details, map} | {:message, <<_::232>>}, ...]} | {:ok, any}
  # def create_organization(_, args, _) do
  #   case Accounts.create_organization(args) do
  #     {:error, changeset} ->
  #       {
  #         :error,
  #         message: "Could not create organization",
  #         details: ChangesetErrors.error_details(changeset)
  #       }

  #     {:ok, organization} ->
  #       {:ok, organization}
  #   end
  # end
end
