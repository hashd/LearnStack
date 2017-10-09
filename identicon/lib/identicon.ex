defmodule Identicon do
  @pixels       7
  @i_pixels     @pixels - 2
  @width        700
  @height       700
  @pixel_width  div( @width, @pixels)
  @pixel_height div(@height, @pixels)

  alias Identicon.Color

  def save(input) do
    input
    |> hash_input
    |> make_image
    |> pick_color
    |> build_grid
    |> build_pixel_map
    |> build_identicon
    |> save_image(input)
  end

  defp hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end

  defp make_image(hex_list) do
    %Identicon.Image{hex: hex_list}
  end

  defp pick_color(%{hex: [r, g, b | _rest]} = image) do
    %Identicon.Image{image | color: %Color{r: r, g: g, b: b}}
  end

  defp build_pixel_map(%{grid: grid, color: color} = _image) do
    grid
    |> Enum.map(fn i -> {(rem(i, @i_pixels) + 1) * @pixel_width, (div(i, @i_pixels) + 1) * @pixel_height, color} end)
  end

  defp build_identicon(pixel_map) do
    image = :egd.create(@width, @height)

    Enum.each pixel_map, fn ({w, h, %{r: r, g: g, b: b}}) ->
      :egd.filledRectangle(image, {w, h}, {w + @pixel_width, h + @pixel_height}, :egd.color({r, g, b}))
    end

    :egd.render image
  end

  defp save_image(image, input) do
    File.write("#{input}.identicon.png", image)
  end

  defp build_grid(%{hex: hex} = image) do
    grid =
      hex
      |> Enum.split(15)
      |> elem(0)
      |> Enum.chunk_every(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
      |> Enum.filter(&(rem(elem(&1, 0) , 2) == 1))
      |> Enum.map(&(elem(&1, 1)))

    %Identicon.Image{image | grid: grid}
  end

  defp mirror_row([v1, v2, v3]), do: [v1, v2, v3, v2, v1]
end
