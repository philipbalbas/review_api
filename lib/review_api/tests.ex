defmodule ReviewApi.Tests do
  @moduledoc """
  The Tests context.
  """

  import Ecto.Query, warn: false
  alias ReviewApi.Repo

  alias ReviewApi.Tests.Card

  # @search [Item, Category]
  # def search(term) do
  #   pattern = "%#{term}%"
  #   Enum.flat_map(@search, &search_ecto(&1, pattern))
  # end

  # defp search_ecto(ecto_schema, pattern) do
  #   Repo.all from q in ecto_schema,
  #     where: ilike(q.name, ^pattern) or ilike(q.description, ^pattern)
  # end

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end

  @doc """
  Returns a list of cards matching the given `criteria`
  """
  def list_cards(criteria) do
    Enum.reduce(criteria, Card, fn
      {:filter, filter}, query ->
        query |> filter_cards_with(filter)

      _, query ->
        query
    end)
    |> Repo.all()
  end

  defp filter_cards_with(query, filters) do
    Enum.reduce(filters, query, fn
      {:exam_id, exam_id}, query ->
        from(q in query, where: q.exam_id == ^exam_id)

      {:topic_id, topic_id}, query ->
        from(q in query, where: q.topic_id == ^topic_id)

      {:category_id, category_id}, query ->
        from(q in query,
          join: t in assoc(q, :topic),
          join: s in assoc(t, :subject),
          join: m in assoc(s, :module),
          join: c in assoc(m, :category),
          where: c.id == ^category_id
        )

      {:level, level}, query ->
        from(q in query, where: q.level == ^level)
    end)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  def upsert_card_choices(%Card{} = card, %{choice_ids: choice_ids}) do
    card
    |> Card.upsert_card_choices(choice_ids)
  end

  def upsert_card_answers(%Card{} = card, %{answer_ids: answer_ids}) do
    card
    |> Card.upsert_card_answers(answer_ids)
  end

  def upsert_question_answers(%Card{} = card, %{choice_ids: choice_ids}) do
    card
    |> Card.upsert_question_answers(choice_ids)
  end

  def upsert_card_exams(%Card{} = card, %{exam_ids: exam_ids}) do
    card |> Card.upsert_card_exams(exam_ids)
  end

  @doc """
  Deletes a Card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{source: %Card{}}

  """
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end

  alias ReviewApi.Tests.Choice

  @doc """
  Returns the list of choices.

  ## Examples

      iex> list_choices()
      [%Choice{}, ...]

  """
  def list_choices do
    Repo.all(Choice)
  end

  def list_choices(criteria) do
    Enum.reduce(criteria, Choice, fn
      {:filter, filter}, query ->
        query |> filter_choice_with(filter)

      _, query ->
        query
    end)
    |> Repo.all()
  end

  defp filter_choice_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:search_term, search_term}, query ->
        from(q in query, where: ilike(q.content, ^search_term))

      {:card_id, card_id}, query ->
        from(q in query,
          join: c in assoc(q, :cards),
          where: c.id == ^card_id
        )
    end)
  end

  @doc """
  Gets a single choice.

  Raises `Ecto.NoResultsError` if the Choice does not exist.

  ## Examples

      iex> get_choice!(123)
      %Choice{}

      iex> get_choice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_choice!(id), do: Repo.get!(Choice, id)

  @doc """
  Creates a choice.

  ## Examples

      iex> create_choice(%{field: value})
      {:ok, %Choice{}}

      iex> create_choice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_choice(attrs \\ %{}) do
    %Choice{}
    |> Choice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a choice.

  ## Examples

      iex> update_choice(choice, %{field: new_value})
      {:ok, %Choice{}}

      iex> update_choice(choice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_choice(%Choice{} = choice, attrs) do
    choice
    |> Choice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Choice.

  ## Examples

      iex> delete_choice(choice)
      {:ok, %Choice{}}

      iex> delete_choice(choice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_choice(%Choice{} = choice) do
    Repo.delete(choice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking choice changes.

  ## Examples

      iex> change_choice(choice)
      %Ecto.Changeset{source: %Choice{}}

  """
  def change_choice(%Choice{} = choice) do
    Choice.changeset(choice, %{})
  end

  alias ReviewApi.Tests.Exam

  @doc """
  Returns the list of exams.

  ## Examples

      iex> list_exams()
      [%Exam{}, ...]

  """
  def list_exams do
    Repo.all(Exam)
  end

  @doc """
  Returns a list of exams matching the given `criteria`
  """
  def list_exams(criteria) do
    query = from(p in Exam)

    Enum.reduce(criteria, query, fn
      {:filter, filters}, query -> filter_exams(filters, query)
    end)
    |> Repo.all()
  end

  defp filter_exams(filters, query) do
    Enum.reduce(filters, query, fn
      {:category_id, id}, query ->
        from(q in query, where: q.category_id == ^id)

      {:type, type}, query ->
        from(q in query, where: q.type == ^type)
    end)
  end

  @doc """
  Gets a single exam.

  Raises `Ecto.NoResultsError` if the Exam does not exist.

  ## Examples

      iex> get_exam!(123)
      %Exam{}

      iex> get_exam!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exam!(id), do: Repo.get!(Exam, id)

  @doc """
  Creates a exam.

  ## Examples

      iex> create_exam(%{field: value})
      {:ok, %Exam{}}

      iex> create_exam(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exam(attrs \\ %{}) do
    %Exam{}
    |> Exam.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exam.

  ## Examples

      iex> update_exam(exam, %{field: new_value})
      {:ok, %Exam{}}

      iex> update_exam(exam, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exam(%Exam{} = exam, attrs) do
    exam
    |> Exam.changeset(attrs)
    |> Repo.update()
  end

  def upsert_exam_cards(%Exam{} = exam, %{card_ids: card_ids}) do
    exam
    |> Exam.upsert_exam_cards(card_ids)
  end

  def upsert_exam_topics(%Exam{} = exam, %{topic_ids: topic_ids}) do
    exam |> Exam.upsert_exam_topics(topic_ids)
  end

  @doc """
  Deletes a Exam.

  ## Examples

      iex> delete_exam(exam)
      {:ok, %Exam{}}

      iex> delete_exam(exam)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exam(%Exam{} = exam) do
    Repo.delete(exam)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exam changes.

  ## Examples

      iex> change_exam(exam)
      %Ecto.Changeset{source: %Exam{}}

  """
  def change_exam(%Exam{} = exam) do
    Exam.changeset(exam, %{})
  end

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Card, %{scope: :exam}) do
    Card
    |> order_by(asc: :id)
  end

  def query(Card, %{scope: :topic}) do
    Card
    |> order_by(asc: :id)
  end

  def query(Choice, %{scope: :card}) do
    Choice
    |> order_by(asc: :id)
  end

  def query(queryable, _) do
    queryable
  end
end
