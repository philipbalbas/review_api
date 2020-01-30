defmodule ReviewApi.Lecture.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field(:description, :string)
    field(:name, :string)

    has_many(:modules, ReviewApi.Lecture.Module)
    has_many(:exams, ReviewApi.Tests.Exam)

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
