defmodule ReviewApiWeb.Resolvers.Lecture do
  alias ReviewApi.Lecture
  alias ReviewApiWeb.Schema.ChangesetErrors

  def modules(_, _, _) do
    {:ok, Lecture.list_modules()}
  end

  def module(_, %{id: id}, _) do
    {:ok, Lecture.get_module!(id)}
  end

  def subjects(_, _, _) do
    {:ok, Lecture.list_subjects()}
  end

  def subject(_, %{id: id}, _) do
    {:ok, Lecture.get_subject!(id)}
  end

  def topics(_, _, _) do
    {:ok, Lecture.list_topics()}
  end

  def topic(_, %{id: id}, _) do
    {:ok, Lecture.get_topic!(id)}
  end

  def pages(_, _, _) do
    {:ok, Lecture.list_pages()}
  end

  def page(_, %{id: id}, _) do
    {:ok, Lecture.get_page!(id)}
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

  def create_subject(_, %{input: input}, _) do
    case Lecture.create_subject(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create subject", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, subject} ->
        {:ok, subject}
    end
  end

  def create_topic(_, %{input: input}, _) do
    case Lecture.create_topic(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create topic", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, topic} ->
        {:ok, topic}
    end
  end

  def create_page(_, %{input: input}, _) do
    case Lecture.create_page(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create page", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, page} ->
        {:ok, page}
    end
  end
end
