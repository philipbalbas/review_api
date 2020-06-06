defmodule ReviewApi.Repo.Migrations.AddOrderToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :order, :integer
    end
  end
end
