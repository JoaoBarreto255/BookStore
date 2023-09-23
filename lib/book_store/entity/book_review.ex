defmodule BookStore.Entity.BookReview do
  use Ecto.Schema
  import Ecto.Changeset

  alias BookStore.Entity.Book
  alias BookStore.Entity.Author

  @fields [:review, :is_cover_review, :author, :book]

  schema "catalog_author_reviewers" do
    field :review, :string
    field :is_cover_review, :boolean

    belongs_to :author, Author
    belongs_to :book, Book
  end

  def changeset(review, params \\ %{}) do
    review
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:review, min: 3)
  end
end
