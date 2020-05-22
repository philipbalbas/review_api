defmodule ReviewApi.Repo.Migrations.AddDescriptionToExams do
  use Ecto.Migration

  def change do
    alter(table(:exams)) do
      add :description, :string
    end
  end
end
