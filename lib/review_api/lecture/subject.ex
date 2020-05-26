defmodule ReviewApi.Lecture.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.{Module, Topic}

  schema "subjects" do
    field :description, :string
    field :name, :string

    belongs_to(:module, Module)
    has_many(:topics, Topic)

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :module_id])
    |> validate_required([:name, :module_id])
    |> unique_constraint([:name, :module_id])
    |> assoc_constraint(:module)
  end
end
