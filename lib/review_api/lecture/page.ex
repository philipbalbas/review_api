defmodule ReviewApi.Lecture.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Topic

  schema "pages" do
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:topic, Topic)

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:name, :description, :content, :topic_id])
    |> unique_constraint(:name)
    |> validate_required([:name, :topic_id])
    |> assoc_constraint(:topic)
  end
end
