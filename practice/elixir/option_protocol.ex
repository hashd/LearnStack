defprotocol Optional do
  def bundle(data)
end

defimpl Optional, for: Atom do
  def bundle(:nil), do: {:none, nil}
  def bundle(atom), do: {:ok, atom}
end

defimpl Optional, for: Integer do
  def bundle(n), do: {:ok, n}
end

defmodule Option do
  def if({:ok, data}, fun), do: fun.(data)
  def if(a, _), do: a

  def or_else({:none, _}, val), do: val
  def or_else(d, _), do: d 
end