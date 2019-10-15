defmodule ReviewApi.Tests.Exam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exams" do
    field :name, :string
    field :type, :string

    belongs_to :category, ReviewApi.Lecture.Category
    many_to_many(:cards, ReviewApi.Tests.Card, join_through: "exams_cards")

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:name, :type, :category_id])
    |> validate_required([:name])
  end
end
