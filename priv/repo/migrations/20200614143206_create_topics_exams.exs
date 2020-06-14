defmodule ReviewApi.Repo.Migrations.CreateTopicsExams do
  use Ecto.Migration

  def change do
    create table(:topics_exams) do
      add :topic_id, references(:topics)
      add :exam_id, references(:exams)
    end

    create unique_index(:topics_exams, [:topic_id, :exam_id])
  end
end
