defmodule BookStore.Repo.Migrations.CreateCatalogBooks do
  use Ecto.Migration

  def change do
    create table(:catalog_authors) do
      add :name, :string
      add :origin, :string
      add :bio, :text
      add :photo, :string
      add :born_at, :date
      add :died_at, :date, null: true
    end

    create table(:catalog_books) do
      add :title, :string
      add :isbn, :string
      add :synopsis, :text, null: true
      add :published_at, :date
      add :min_age, :integer
    end

    create table(:catalog_book_authors) do
      add :author_id, references(:catalog_authors)
      add :book_id, references(:catalog_books)
    end

    create table(:catalog_author_reviewers) do
      add :book_id, references(:catalog_books)
      add :author_id, references(:catalog_authors)
      add :review, :text
      add :is_cover_review, :boolean
    end

    create unique_index(:catalog_books, [:isbn])
  end
end
