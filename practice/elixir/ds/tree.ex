defmodule Tree do
  defstruct data: nil, children: []

  def add_child(%Tree{children: children} = tree, data) do
    %Tree{tree | children: [%Tree{data: data} | children]}
  end
end