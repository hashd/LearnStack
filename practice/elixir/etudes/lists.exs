defmodule MLModule do
  def get_adults(list), do: get_adults(list, [])

  def get_adults([], acc), do: Enum.reverse(acc)
  def get_adults([{name, gender, age} | rest], acc) when gender == "M" and age > 40 do
    get_adults(rest, [{name, gender, age} | acc])
  end
  def get_adults([person | rest], acc), do: get_adults(rest, acc)
end

defmodule Stats do
  def mean(list) when is_list(list) do
    list
    |> List.foldl(0, &(&1 + &2))
    |> :erlang./(length(list))
  end

  def standard_deviation(list) when is_list(list) and length(list) > 1 do
    {sum, sum_of_squares} = List.foldl(list, {0,0}, &({&1 + elem(&2,0), &1*&1 + elem(&2,1)}))
    list_length    = length(list)

    :math.sqrt((list_length * sum_of_squares - sum * sum)/(list_length * (list_length - 1)))
  end
end

MLModule.get_adults([{"Federico", "M", 22}, {"Kim", "F", 45}, {"Hansa", "F", 30},
  {"Tran", "M", 47}, {"Cathy", "F", 32}, {"Elias", "M", 50}])
Stats.mean([1,2,3,4,5,6])
Stats.standard_deviation([7,2,9])
