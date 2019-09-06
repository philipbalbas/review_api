defmodule ReviewApi.Lecture.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modules" do
    field :description, :string
    field :name, :string

    has_many(:subjects, ReviewApi.Lecture.Subject)

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
