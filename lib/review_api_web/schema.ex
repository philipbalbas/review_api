defmodule ReviewApiWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias Absinthe.Relay.Node.Helpers
  alias ReviewApiWeb.Resolvers
  import_types(ReviewApiWeb.Schema.Types)

  alias ReviewApi.{Accounts, Lecture, Tests}

  node interface do
    resolve_type(fn
      %ReviewApi.Accounts.Organization{}, _ ->
        :organization

      %ReviewApi.Accounts.User{}, _ ->
        :user

      %ReviewApi.Lecture.Category{}, _ ->
        :category

      %ReviewApi.Lecture.Module{}, _ ->
        :module

      %ReviewApi.Lecture.Subject{}, _ ->
        :subject

      %ReviewApi.Lecture.Topic{}, _ ->
        :topic

      %ReviewApi.Lecture.Page{}, _ ->
        :page

      %ReviewApi.Lecture.Note{}, _ ->
        :note

      %ReviewApi.Tests.Exam{}, _ ->
        :exam

      %ReviewApi.Tests.Card{}, _ ->
        :card

      %ReviewApi.Tests.Choice{}, _ ->
        :choice

      _, _ ->
        nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :organization, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Accounts.Organization, local_id)}

        %{type: :user, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Accounts.User, local_id)}

        %{type: :category, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Category, local_id)}

        %{type: :module, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Module, local_id)}

        %{type: :subject, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Subject, local_id)}

        %{type: :topic, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Topic, local_id)}

        %{type: :page, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Page, local_id)}

        %{type: :note, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Note, local_id)}

        %{type: :exam, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Exam, local_id)}

        %{type: :card, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Card, local_id)}

        %{type: :choice, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Choice, local_id)}

        _, _ ->
          {:error, "Unknown node"}
      end)
    end

    @desc "Get a list of organizations"
    field :list_organizations, list_of(:organization) do
      resolve(&Resolvers.Accounts.list_organizations/3)
    end

    @desc "Get an organization"
    field :get_organization, :organization do
      arg(:id, non_null(:id))

      resolve(Helpers.parsing_node_ids(&Resolvers.Accounts.get_organization/2, id: :organization))
    end

    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.list_users/3)
    end

    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Accounts.get_user/2, id: :user))
    end

    @desc "Get a list of categories"
    field :list_categories, list_of(non_null(:category)) do
      resolve(&Resolvers.Lecture.list_categories/3)
    end

    @desc "Get a single category"
    field :get_category, :category do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.get_category/2, id: :category))
    end

    @desc "Get a list of modules"
    field :modules, list_of(:module) do
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Lecture.modules/3)
    end

    @desc "Get a single module"
    field :module, :module do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.module/2, id: :module))
    end

    @desc "Get a list subjects"
    field :subjects, list_of(:subject) do
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Lecture.subjects/3)
    end

    @desc "Get a single subject"
    field :subject, :subject do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.subject/2, id: :subject))
    end

    @desc "Get a list topics"
    field :topics, list_of(:topic) do
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Lecture.topics/3)
    end

    @desc "Get a single topic"
    field :topic, :topic do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.topic/2, id: :topic))
    end

    @desc "Get a list of pages"
    field :pages, list_of(:page) do
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Lecture.pages/3)
    end

    @desc "Get a single page"
    field :page, :page do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.page/2, id: :page))
    end

    @desc "Get a list of notes"
    field :notes, list_of(:note) do
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Lecture.notes/3)
    end

    @desc "Get a single note"
    field :note, :note do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Lecture.note/2, id: :note))
    end

    @desc "Get a list of exams"
    field :list_exams, list_of(non_null(:exam)) do
      arg(:filter, :exam_filter)
      resolve(&Resolvers.Tests.list_exams/3)
    end

    @desc "Get a single exam"
    field :get_exam, :exam do
      arg(:id, non_null(:id))
      resolve(Helpers.parsing_node_ids(&Resolvers.Tests.get_exam/2, id: :exam))
    end

    @desc "Get a list of cards"
    field :list_cards, list_of(non_null(:card)) do
      arg(:filter, :card_filter)
      resolve(&Resolvers.Tests.list_cards/3)
    end
  end

  mutation do
    @desc "Create an organization"
    payload field :create_organization do
      input do
        field :input_data, non_null(:organization_input)
      end

      output do
        field :result, :organization
      end

      resolve(&Resolvers.Accounts.create_organization/3)
    end

    @desc "Signin a user"
    field :signin, :session do
      arg(:email, :string)
      arg(:password, :string)
      resolve(&Resolvers.Accounts.signin/3)
    end

    @desc "Signup a user"
    field :signup, :user do
      arg(:input, non_null(:user_input))
      resolve(&Resolvers.Accounts.signup/3)
    end

    @desc "Create a category"
    field :create_category, :category do
      arg(:input, non_null(:create_category_input))
      resolve(&Resolvers.Lecture.create_category/3)
    end

    @desc "Update a category"
    field :update_category, :category do
      arg(:input, non_null(:update_category_input))
      resolve(&Resolvers.Lecture.update_category/3)
    end

    @desc "Create a module"
    field :create_module, :module do
      arg(:input, non_null(:module_input))
      resolve(&Resolvers.Lecture.create_module/3)
    end

    @desc "Create a subject"
    field :create_subject, :subject do
      arg(:input, non_null(:subject_input))
      resolve(&Resolvers.Lecture.create_subject/3)
    end

    @desc "Create a topic"
    field :create_topic, :topic do
      arg(:input, non_null(:topic_input))
      resolve(&Resolvers.Lecture.create_topic/3)
    end

    @desc "Create a page"
    field :create_page, :page do
      arg(:input, non_null(:page_input))
      resolve(&Resolvers.Lecture.create_page/3)
    end

    @desc "Update a module"
    field :update_module, :module do
      arg(:input, non_null(:update_module_input))
      resolve(&Resolvers.Lecture.update_module/3)
    end

    @desc "Update a subject"
    field :update_subject, :subject do
      arg(:input, non_null(:update_subject_input))
      resolve(&Resolvers.Lecture.update_subject/3)
    end

    @desc "Update a topic"
    field :update_topic, :topic do
      arg(:input, non_null(:update_topic_input))
      resolve(&Resolvers.Lecture.update_topic/3)
    end

    @desc "Update a page"
    field :update_page, :page do
      arg(:input, non_null(:update_page_input))
      resolve(&Resolvers.Lecture.update_page/3)
    end

    @desc "Create a note"
    field :create_note, :note do
      arg(:input, non_null(:note_input))
      resolve(&Resolvers.Lecture.create_note/3)
    end

    @desc "Update a note"
    field :update_note, :note do
      arg(:input, non_null(:update_note_input))
      resolve(&Resolvers.Lecture.update_note/3)
    end

    @desc "Create an exam"
    field :create_exam, :exam do
      arg(:input, non_null(:create_exam_input))
      resolve(&Resolvers.Tests.create_exam/3)
    end

    @desc "Update an exam"
    field :update_exam, :exam do
      arg(:input, non_null(:update_exam_input))
      resolve(&Resolvers.Tests.update_exam/3)
    end

    @desc "Create a card"
    field :create_card, :card do
      arg(:input, non_null(:create_card_input))
      resolve(&Resolvers.Tests.create_card/3)
    end

    @desc "Create a choice"
    field :create_choice, :choice do
      arg(:input, non_null(:create_choice_input))
      resolve(&Resolvers.Tests.create_choice/3)
    end

    @desc "Add choices to card"
    field :upsert_card_choices, :card do
      arg(:input, non_null(:upsert_card_choices_input))
      resolve(&Resolvers.Tests.upsert_card_choices/3)
    end

    @desc "Add answers to question"
    field :upsert_question_answers, :card do
      arg(:input, non_null(:upsert_question_answers_input))
      resolve(&Resolvers.Tests.upsert_question_answers/3)
    end

    @desc "Add cards to exam"
    field :upsert_exam_cards, :exam do
      arg(:input, non_null(:upsert_exam_cards_input))
      resolve(&Resolvers.Tests.upsert_exam_cards/3)
    end
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.datasource())
      |> Dataloader.add_source(Lecture, Lecture.datasource())
      |> Dataloader.add_source(Tests, Tests.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
