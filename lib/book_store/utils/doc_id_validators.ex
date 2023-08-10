defmodule BookStore.Utils.DocIdValidators do
  def validate_isbn(isbn) do
    cleaned_isbn = String.replace(isbn, ~r/\D/, "")
    len = String.length(cleaned_isbn)
    if len != 13 do
      {:fail, "ISBN must have only 13 digits [0-9], got " <> Integer.to_string(len) <> "!"}
    else
      cleaned_isbn
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.zip([1,3,1,3,1,3,1,3,1,3,1,3,1])
      |> Enum.map(fn {x, y} -> x * y end)
      |> Enum.zip(1..13)
      |> Enum.reduce(0, fn e, acc -> case e do
          {0, 13} -> rem(acc, 10) == 0
          {val, 13} -> 10 - rem(acc, 10) == val
          {val, _} -> val + acc
        end
      end)
      |> case do
        true -> {:success, cleaned_isbn}
        false -> {:fail, "ISBN \"" <> isbn <> "\" is not valid"}
      end
    end
  end

  @spec validate_isbn_field(Ecto.Changeset.t, atom) :: Ecto.Changeset.t
  def validate_isbn_field(set, atom) do
    changes = Map.get(set, :changes)
    errors = Map.get(set, :errors)
    value = Map.get(changes, atom)
    if not is_nil(value) do
      validate_isbn(value)
      |> case do
        {:success, cleaned_isbn} -> Map.put(set, :valid?, Map.get(set, :valid?, true))
          |> Map.put(:changes, Map.put(changes, atom, cleaned_isbn))
        {:fail, message} -> Map.put(set, :valid?, false)
          |> Map.put(:changes, Map.drop(changes, [atom]))
          |> Map.put(:errors, Keyword.put(errors, atom, {message, [type: :string, validation: :validate_isbn]}))
      end
    else
      set
    end
  end
end
