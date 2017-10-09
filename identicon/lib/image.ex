defmodule Identicon.Image do
  alias Identicon.Color

  defstruct hex: nil, color: %Color{}, grid: [[]]
end
