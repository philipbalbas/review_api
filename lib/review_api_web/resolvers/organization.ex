defmodule ReviewApiWeb.Resolvers.Organization do
  alias ReviewApi.Accounts
  alias ReviewApiWeb.Schema.ChangesetErrors

  def organizations(_, _, _) do
    {:ok, Accounts.list_organizations()}
  end

  def organization(%{id: id}, _) do
    {:ok, Accounts.get_organization!(id)}
  end

  def create_organization(_, args, _) do
    case Accounts.create_organization(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create organization",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, organization} ->
        {:ok, organization}
    end
  end
end
