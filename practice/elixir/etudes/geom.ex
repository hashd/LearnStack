defmodule Geom do
  @moduledoc """
  Contains all geometry related functions
  """

  defp area(:rectangle, x, y), do: x * y
  defp area(:triangle, x, y), do: x * y * 0.5
  defp area(:ellipsis, x, y), do: x * y * :math.pi
  defp area(a, _, _), do: "Unsupported geometrical structure: #{a}"

  def area({x,y,z}) when y >= 0 and z >= 0, do: area(x, y, z)
end