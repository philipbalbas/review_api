defmodule ReviewApiWeb.Schema do
  use Absinthe.Schema
  alias ReviewApiWeb.Resolvers
  import_types(ReviewApiWeb.Schema.Types)

  alias ReviewApi.{Accounts, Lecture}

  query do
    @desc "Get a list of organizations"
    field :organizations, list_of(:organization) do
      resolve(&Resolvers.Organization.organizations/3)
    end

    @desc "Get an organization"
    field :organization, :organization do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Organization.organization/3)
    end

    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve(&Resolvers.User.users/3)
    end

    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.User.user/3)
    end

    @desc "Get a list of modules"
    field :modules, list_of(:module) do
      resolve(&Resolvers.Lecture.modules/3)
    end

    @desc "Get a single module"
    field :module, :module do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Lecture.module/3)
    end

    @desc "Get a list subjects"
    field :subjects, list_of(:subject) do
      resolve(&Resolvers.Lecture.subjects/3)
    end

    @desc "Get a single subject"
    field :subject, :subject do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Lecture.subject/3)
    end

    @desc "Get a list topics"
    field :topics, list_of(:topic) do
      resolve(&Resolvers.Lecture.topics/3)
    end

    @desc "Get a single topic"
    field :topic, :topic do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Lecture.topic/3)
    end

    @desc "Get a list of pages"
    field :pages, list_of(:page) do
      resolve(&Resolvers.Lecture.pages/3)
    end

    @desc "Get a single page"
    field :page, :page do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Lecture.page/3)
    end

    @desc "Get a list of notes"
    field :notes, list_of(:note) do
      resolve(&Resolvers.Lecture.notes/3)
    end

    @desc "Get a single note"
    field :note, :note do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Lecture.note/3)
    end
  end

  mutation do
    @desc "Create an organization"
    field :create_organization, :organization do
      arg(:city, :string)
      arg(:email, :string)
      arg(:name, non_null(:string))
      arg(:phone, :string)
      arg(:street, :string)
      arg(:role, non_null(:string))
      resolve(&Resolvers.Organization.create_organization/3)
    end

    @desc "Signup a user"
    field :signup, :user do
      arg(:input, non_null(:user_input))
      resolve(&Resolvers.User.signup/3)
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
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.datasource())
      |> Dataloader.add_source(Lecture, Lecture.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
