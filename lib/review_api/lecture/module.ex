defmodule ReviewApi.Lecture.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modules" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
