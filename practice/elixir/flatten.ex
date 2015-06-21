defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head) === false, do: [ head | flatten(tail)]
  def flatten([head | tail]) when is_list(head) === true, do: flatten(head) ++ flatten(tail)
end