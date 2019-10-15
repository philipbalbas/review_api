defmodule ReviewApi.Lecture.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Subject

  schema "topics" do
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:subject, Subject)
    has_many(:pages, ReviewApi.Lecture.Page)
    has_many(:cards, ReviewApi.Tests.Card)

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name, :description, :content, :subject_id])
    |> unique_constraint(:name)
    |> validate_required([:name, :subject_id])
    |> assoc_constraint(:subject)
  end
end
