defmodule ReviewApiWeb.Resolvers.Lecture do
  alias ReviewApi.Lecture
  alias ReviewApiWeb.Schema.ChangesetErrors

  def modules(_, _, _) do
    {:ok, Lecture.list_modules()}
  end

  def module(_, %{id: id}, _) do
    {:ok, Lecture.get_module!(id)}
  end

  def create_module(_, %{input: input}, _) do
    case Lecture.create_module(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create module", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, module} ->
        {:ok, module}
    end
  end
end
