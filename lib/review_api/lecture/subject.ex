defmodule ReviewApi.Lecture.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Module

  schema "subjects" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string

    belongs_to(:module, Module)

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :description, :completed])
  end
end
