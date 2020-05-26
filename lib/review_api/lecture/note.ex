defmodule ReviewApi.Lecture.Note do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Page

  schema "notes" do
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:page, Page)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:name, :description, :content, :page_id])
    |> unique_constraint([:name, :page_id])
    |> validate_required([:name, :page_id])
    |> assoc_constraint(:page)
  end
end
