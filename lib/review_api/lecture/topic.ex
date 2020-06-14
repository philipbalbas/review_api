defmodule ReviewApi.Lecture.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Subject

  schema "topics" do
    field :content, :string
    field :description, :string
    field :name, :string
    field :order, :integer

    belongs_to(:subject, Subject)
    has_many(:pages, ReviewApi.Lecture.Page)
    has_many(:cards, ReviewApi.Tests.Card)
    many_to_many(:exams, ReviewApi.Tests.Exam, join_through: "topics_exams", on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name, :description, :content, :order, :subject_id])
    |> unique_constraint([:name, :subject_id])
    |> validate_required([:name, :subject_id])
    |> assoc_constraint(:subject)
  end
end
