defmodule ReviewApi.Tests.Exam do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias ReviewApi.{Tests, Repo, Lecture}
  alias Tests.Card
  alias Lecture.Topic

  schema "exams" do
    field :name, :string
    field :type, :string
    field :description, :string
    field :order, :integer

    belongs_to :category, ReviewApi.Lecture.Category
    many_to_many(:cards, ReviewApi.Tests.Card, join_through: "exams_cards", on_replace: :delete)

    many_to_many(:topics, ReviewApi.Lecture.Topic,
      join_through: "topics_exams",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:name, :type, :description, :order, :category_id])
    |> validate_required([:name, :category_id])
    |> unique_constraint([:name, :category_id])
    |> assoc_constraint(:category)
  end

  def changeset_update_cards(exam, cards) do
    exam
    |> Repo.preload(:cards)
    |> cast(%{}, [:id])
    |> put_assoc(:cards, cards)
  end

  def upsert_exam_cards(exam, answer_ids) when is_list(answer_ids) do
    cards =
      Card
      |> where([answer], answer.id in ^answer_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           exam
           |> changeset_update_cards(cards)
           |> Repo.update() do
      {:ok, Tests.get_exam!(exam.id)}
    else
      error -> error
    end
  end

  def changeset_update_topics(exam, topics) do
    exam
    |> Repo.preload(:topics)
    |> cast(%{}, [:id])
    |> put_assoc(:topics, topics)
  end

  def upsert_exam_topics(exam, topic_ids) when is_list(topic_ids) do
    topics =
      Topic
      |> where([topic], topic.id in ^topic_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           exam
           |> changeset_update_topics(topics)
           |> Repo.update() do
      {:ok, Tests.get_exam!(exam.id)}
    else
      error -> error
    end
  end
end
