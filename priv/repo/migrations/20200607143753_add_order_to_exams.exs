defmodule ReviewApi.Repo.Migrations.AddOrderToExams do
  use Ecto.Migration

  def change do
    alter table(:exams) do
      add :order, :integer
    end
  end
end
