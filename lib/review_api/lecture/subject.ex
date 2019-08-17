defmodule ReviewApi.Lecture.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Module

  schema "subjects" do
    field :description, :string
    field :name, :string

    belongs_to(:module, Module)
    has_many(:topics, ReviewApi.Lecture.Topic)

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :module_id])
    |> unique_constraint(:name)
    |> validate_required([:name, :module_id])
    |> assoc_constraint(:module)
  end
end
