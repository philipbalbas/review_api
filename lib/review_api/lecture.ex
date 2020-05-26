defmodule ReviewApi.Lecture do
  @moduledoc """
  The Lecture context.
  """

  import Ecto.Query, warn: false
  alias ReviewApi.Repo
  alias ReviewApi.Lecture.{Module, Subject, Topic, Page, Note, Category}

  @doc """
  Returns the list of modules.

  ## Examples

      iex> list_modules()
      [%Module{}, ...]

  """
  def list_modules do
    Repo.all(Module)
  end

  def list_modules(criteria) do
    query = from(p in Module)

    Enum.reduce(criteria, query, fn
      {:order, order}, query ->
        from(p in query, order_by: [{^order, :id}])
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single module.

  Raises `Ecto.NoResultsError` if the Module does not exist.

  ## Examples

      iex> get_module!(123)
      %Module{}

      iex> get_module!(456)
      ** (Ecto.NoResultsError)

  """
  def get_module!(id), do: Repo.get!(Module, id)

  @doc """
  Creates a module.

  ## Examples

      iex> create_module(%{field: value})
      {:ok, %Module{}}

      iex> create_module(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_module(attrs \\ %{}) do
    %Module{}
    |> Module.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a module.

  ## Examples

      iex> update_module(module, %{field: new_value})
      {:ok, %Module{}}

      iex> update_module(module, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_module(%Module{} = module, attrs) do
    module
    |> Module.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Module.

  ## Examples

      iex> delete_module(module)
      {:ok, %Module{}}

      iex> delete_module(module)
      {:error, %Ecto.Changeset{}}

  """
  def delete_module(%Module{} = module) do
    Repo.delete(module)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking module changes.

  ## Examples

      iex> change_module(module)
      %Ecto.Changeset{source: %Module{}}

  """
  def change_module(%Module{} = module) do
    Module.changeset(module, %{})
  end

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects()
      [%Subject{}, ...]

  """
  def list_subjects do
    Repo.all(Subject)
  end

  def list_subjects(criteria) do
    query = from(p in Subject)

    Enum.reduce(criteria, query, fn
      {:order, order}, query ->
        from(p in query, order_by: [{^order, :id}])

      {:module_id, module_id}, query ->
        from(p in query, where: p.module_id == ^module_id)
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single subject.

  Raises `Ecto.NoResultsError` if the Subject does not exist.

  ## Examples

      iex> get_subject!(123)
      %Subject{}

      iex> get_subject!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subject!(id), do: Repo.get!(Subject, id)

  @doc """
  Creates a subject.

  ## Examples

      iex> create_subject(%{field: value})
      {:ok, %Subject{}}

      iex> create_subject(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subject(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subject.

  ## Examples

      iex> update_subject(subject, %{field: new_value})
      {:ok, %Subject{}}

      iex> update_subject(subject, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subject(%Subject{} = subject, attrs) do
    subject
    |> Subject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Subject.

  ## Examples

      iex> delete_subject(subject)
      {:ok, %Subject{}}

      iex> delete_subject(subject)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subject(%Subject{} = subject) do
    Repo.delete(subject)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subject changes.

  ## Examples

      iex> change_subject(subject)
      %Ecto.Changeset{source: %Subject{}}

  """
  def change_subject(%Subject{} = subject) do
    Subject.changeset(subject, %{})
  end

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  def list_topics(criteria) do
    query = from(p in Topic)

    Enum.reduce(criteria, query, fn
      {:order, order}, query ->
        from(p in query, order_by: [{^order, :id}])

      {:subject_id, subject_id}, query ->
        from(p in query, where: p.subject_id == ^subject_id)
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Repo.all(Page)
  end

  def list_pages(criteria) do
    query = from(p in Page)

    Enum.reduce(criteria, query, fn
      {:order, order}, query ->
        from(p in query, order_by: [{^order, :id}])
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Page{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id), do: Repo.get!(Page, id)

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{source: %Page{}}

  """
  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes do
    Repo.all(Note)
  end

  def list_notes(criteria) do
    query = from(p in Note)

    Enum.reduce(criteria, query, fn
      {:order, order}, query ->
        from(p in query, order_by: [{^order, :id}])
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Subject, %{scope: :module}) do
    Subject
    |> order_by(asc: :id)
  end

  def query(Topic, %{scope: :subject}) do
    Topic
    |> order_by(asc: :id)
  end

  def query(Page, %{scope: :topic}) do
    Page
    |> order_by(asc: :id)
  end

  def query(Note, %{scope: :page}) do
    Note
    |> order_by(asc: :id)
  end

  def query(queryable, _) do
    queryable
  end

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end
end
