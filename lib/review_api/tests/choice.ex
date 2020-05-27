defmodule ReviewApi.Tests.Choice do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Tests

  schema "choices" do
    field :content, :string

    many_to_many :questions, Tests.Card, join_through: "questions_answers", on_replace: :delete
    many_to_many :cards, Tests.Card, join_through: "cards_choices", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(choice, attrs) do
    choice
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> unique_constraint(:content)
  end
end
