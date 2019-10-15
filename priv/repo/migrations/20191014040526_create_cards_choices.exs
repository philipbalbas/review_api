defmodule ReviewApi.Repo.Migrations.CreateCardsChoices do
  use Ecto.Migration

  def change do
    create table(:cards_choices) do
      add :card_id, references(:cards)
      add :choice_id, references(:choices)
    end

    create unique_index(:cards_choices, [:card_id, :choice_id])
  end
end
