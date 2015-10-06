defmodule Neutron do
  defstruct weights: [], bias: [], func: fn -> nil end

  def init(weights, bias, func) do
    %__MODULE__{}
  end
end