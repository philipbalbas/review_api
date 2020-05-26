defmodule ReviewApi.Lecture.Module do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.{Category, Subject}

  schema "modules" do
    field :description, :string
    field :name, :string
    # field :slug, :string

    belongs_to(:category, Category)
    has_many(:subjects, Subject)

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :description, :category_id])
    |> validate_required([:name, :category_id])
    |> unique_constraint([:name, :category_id])
    |> assoc_constraint(:category)
  end
end
