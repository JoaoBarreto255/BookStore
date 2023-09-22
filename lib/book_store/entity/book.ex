defmodule BookStore.Entity.Book do
  use Ecto.Schema
  import Ecto.Changeset
  import BookStore.Utils.DocIdValidators

  alias BookStore.Entity.Author

  @fields [:title, :isbn, :synopsis, :published_at, :min_age]
  @req_fields [:title, :isbn, :published_at, :min_age]

  schema "catalog_books" do
    field :title, :string
    field :isbn, :string
    field :synopsis, :string
    field :published_at, :date
    field :min_age, :integer

    many_to_many :authors, Author, join_through: "catalog_book_authors"

    timestamps()
  end

  @spec changeset(Ecto.Schema.t, map) :: Ecto.Changeset.t
  def changeset(book, params \\ %{}) do
    book
    |> cast(params, @fields)
    |> validate_required(@req_fields)
    |> validate_length(:title, min: 1)
    |> validate_isbn_field(:isbn)
    |> validate_number(:min_age, min: 0)
  end
end
