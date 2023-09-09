defmodule BookStore.Utils.UtilValidators do
  @spec validate_name(String.t, integer) :: boolean
  def validate_name(name, max_size \\ 255) do
    name
    |> String.replace(~r/\s/, "")
    |> String.length()
    |> (fn x -> x > 0 and x <= max_size end).()
  end

  @spec validate_name_field(Ecto.Changeset.t, atom) :: Ecto.Changeset.t
  def validate_name_field(set, atom, max_size \\ 255) do
    changes = Map.get(set, :changes)
    errors = Map.get(set, :errors)
    value = Map.get(changes, atom)
    is_valid = Map.get(set, :valid?, true)
    if is_nil(value) or validate_name(value, max_size) do
      Map.put(set, :valid?, is_valid)
    else
      Map.put(set, :valid?, false)
      |> Map.put(:errors, Keyword.put(errors, atom, {'Name could not be empty string',[type: :string, validation: :validate_name]}))
      |> Map.put(:changes, Map.drop(changes, [atom]))
    end
  end
end
