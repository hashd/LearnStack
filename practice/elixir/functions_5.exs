Enum.map 1..4, &(&1+2)
Enum.each 1..4, &(IO.inspect &1)