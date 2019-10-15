defmodule ReviewApi.Repo.Migrations.CreateChoices do
  use Ecto.Migration

  def change do
    create table(:choices) do
      add(:content, :string)

      timestamps()
    end

    create(unique_index(:choices, [:content]))
  end
end
