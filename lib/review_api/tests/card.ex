defmodule ReviewApi.Tests.Card do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias ReviewApi.{Tests, Lecture, Repo}
  alias Tests.Choice

  schema "cards" do
    field :question, :string
    field :rationale, :string
    field :type, :string

    many_to_many :answers, Tests.Choice, join_through: "questions_answers", on_replace: :delete
    many_to_many :choices, Tests.Choice, join_through: "cards_choices", on_replace: :delete
    many_to_many :exams, Tests.Exam, join_through: "exams_cards", on_replace: :delete
    belongs_to :topic, Lecture.Topic

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:question, :rationale, :type, :topic_id])
    |> validate_required([:question, :topic_id])
    |> unique_constraint([:question, :topic_id])
    |> assoc_constraint(:topic)
  end

  def changeset_update_choices(card, choices) do
    card
    |> Repo.preload(:choices)
    |> cast(%{}, [:id])
    |> put_assoc(:choices, choices)
  end

  def upsert_card_choices(card, choice_ids) when is_list(choice_ids) do
    choices =
      Choice
      |> where([choice], choice.id in ^choice_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           card
           |> changeset_update_choices(choices)
           |> Repo.update() do
      {:ok, Tests.get_card!(card.id)}
    else
      error -> error
    end
  end

  def changeset_update_answers(question, answers) do
    question
    |> Repo.preload(:answers)
    |> cast(%{}, [:id])
    |> put_assoc(:answers, answers)
  end

  def upsert_question_answers(question, answer_ids) when is_list(answer_ids) do
    answers =
      Choice
      |> where([answer], answer.id in ^answer_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           question
           |> changeset_update_answers(answers)
           |> Repo.update() do
      {:ok, Tests.get_card!(question.id)}
    else
      error -> error
    end
  end
end
