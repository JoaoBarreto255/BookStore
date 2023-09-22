defmodule BookStore.Entity.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import BookStore.Utils.UtilValidators

  alias BookStore.Entity.Book

  @fields [:name, :origin, :bio, :photo, :born_at, :died_at]
  @rec_fields [:name, :origin, :bio, :photo, :born_at]

  schema "catalog_authors" do
    field :name, :string
    field :origin, :string
    field :bio, :string
    field :photo, :string
    field :born_at, :date
    field :died_at, :date

    many_to_many :books, Book, join_through: "catalog_book_authors"
  end

  def changeset(author, params \\ %{}) do
    author
    |> cast(params, @fields)
    |> validate_required(@rec_fields)
    |> validate_name_field(:name, 255)
    |> validate_name_field(:origin, 255)
    |> validate_length(:bio, min: 120)
  end

end
