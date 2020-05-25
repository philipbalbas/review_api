defmodule ReviewApiWeb.Resolvers.Lecture do
  alias ReviewApi.Lecture
  alias ReviewApiWeb.Schema.ChangesetErrors

  def list_categories(_, _, _) do
    {:ok, Lecture.list_categories()}
  end

  def get_category(%{id: id}, _) do
    {:ok, Lecture.get_category!(id)}
  end

  def modules(_, args, _) do
    {:ok, Lecture.list_modules(args)}
  end

  def module(%{id: id}, _) do
    {:ok, Lecture.get_module!(id)}
  end

  def subjects(_, args, _) do
    {:ok, Lecture.list_subjects(args)}
  end

  def subject(%{id: id}, _) do
    {:ok, Lecture.get_subject!(id)}
  end

  def topics(_, args, _) do
    {:ok, Lecture.list_topics(args)}
  end

  def topic(%{id: id}, _) do
    {:ok, Lecture.get_topic!(id)}
  end

  def pages(_, args, _) do
    {:ok, Lecture.list_pages(args)}
  end

  def page(%{id: id}, _) do
    {:ok, Lecture.get_page!(id)}
  end

  def notes(_, args, _) do
    {:ok, Lecture.list_notes(args)}
  end

  def note(%{id: id}, _) do
    {:ok, Lecture.get_note!(id)}
  end

  def create_category(_, %{input_data: args}, _) do
    case Lecture.create_category(args) do
      {:error, changeset} ->
        {:error,
         message: "Could not create category", details: ChangesetErrors.error_details(changeset)}

      {:ok, category} ->
        {:ok, %{result: category}}
    end
  end

  def update_category(_, %{input_data: input}, _) do
    {:ok, %{id: internal_id}} =
      Absinthe.Relay.Node.from_global_id(input[:id], ReviewApiWeb.Schema)

    category = Lecture.get_category!(internal_id)

    case Lecture.update_category(category, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not update category", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, category} ->
        {:ok, %{result: category}}
    end
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

  def update_module(_, %{input: input}, _) do
    module = Lecture.get_module!(input[:id])

    case Lecture.update_module(module, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not update module", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, module} ->
        {:ok, module}
    end
  end

  def update_subject(_, %{input: input}, _) do
    subject = Lecture.get_subject!(input[:id])

    case Lecture.update_subject(subject, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not update subject", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, subject} ->
        {:ok, subject}
    end
  end

  def update_topic(_, %{input: input}, _) do
    topic = Lecture.get_topic!(input[:id])

    case Lecture.update_topic(topic, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not update topic", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, topic} ->
        {:ok, topic}
    end
  end

  def update_page(_, %{input: input}, _) do
    page = Lecture.get_page!(input[:id])

    case Lecture.update_page(page, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not update page", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, page} ->
        {:ok, page}
    end
  end

  def create_note(_, %{input: input}, _) do
    case Lecture.create_note(input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create note", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, note} ->
        {:ok, note}
    end
  end

  def update_note(_, %{input: input}, _) do
    note = Lecture.get_note!(input[:id])

    case Lecture.update_note(note, input) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not edit note", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, note} ->
        {:ok, note}
    end
  end
end
