defmodule Random do
  def gen_passwd(n), do: Enum.map(1..n, fn _n -> (:random.uniform(90) + ?\s + 1) end)
end