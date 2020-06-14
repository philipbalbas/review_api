defmodule ReviewApi.Repo.Migrations.AddLevelToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :level, :string
    end
  end
end
