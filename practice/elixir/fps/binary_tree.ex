defmodule BinaryTree do
  defstruct value: nil, left: nil, right: nil

  def new do
    %BinaryTree{}
  end

  def size(nil), do: 0
  def size(%BinaryTree{} = r) do
    1 + size(r.left) + size(r.right)
  end
end