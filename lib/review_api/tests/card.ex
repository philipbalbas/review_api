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

    # many_to_many(:answers, Tests.Choice)
    many_to_many :choices, Tests.Choice, join_through: "cards_choices", on_replace: :delete
    many_to_many :exam, Tests.Exam, join_through: "exams_cards", on_replace: :delete
    belongs_to :topic, Lecture.Topic

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:question, :rationale, :type, :topic_id])
    |> validate_required([:question])
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
end
