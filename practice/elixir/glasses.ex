defmodule Glasses do
  def spill(n) do
    spill(0, [n], [[n]])
    |> elem(1)
    |> pretty_print
  end

  defp pretty_print(list) do
    Enum.each(list, &IO.inspect/1)
  end

  defp spill(lvl, spills, spilt) do
    if Enum.all?(spills, &(&1 == 0)) do
      {lvl, spilt |> Enum.map(fn lvl_state -> 
        Enum.map(lvl_state, fn val -> 
          if val > 1, do: 1, else: val 
        end) 
      end) |> Enum.reverse}
    else
      {spills, spilt} = spill(lvl, 0, spills, [[] | spilt])
      spill(lvl + 1, spills, spilt)
    end
  end

  defp spill(lvl, 0 = pos, [h | _t] = spills, [curr_lvl | prev_lvls]) when h > 1 do
    spill(lvl, pos + 1, spills, [[ (h-1)/2 | curr_lvl] | prev_lvls])
  end
  defp spill(lvl, 0 = pos, [h | _t] = spills, [curr_lvl | prev_lvls]) when h >= 0 and h <= 1 do
    spill(lvl, pos + 1, spills, [[ 0 | curr_lvl] | prev_lvls])
  end
  defp spill(_lvl, _pos, [h | []], [curr_lvl | prev_lvls]) when h > 1 do
    curr_lvl = [ (h-1)/2 | curr_lvl] |> Enum.reverse
    { curr_lvl, [ curr_lvl | prev_lvls] }
  end
  defp spill(_lvl, _pos, [h | []], [curr_lvl | prev_lvls]) when h >= 0 and h <= 1 do
    curr_lvl = [ 0 | curr_lvl] |> Enum.reverse
    { curr_lvl, [ curr_lvl | prev_lvls] }
  end
  defp spill(lvl, pos, [h1, h2 | t], [curr_lvl | prev_lvls]) when h1 > 1 and h2 > 1, do: spill(lvl, pos + 1, [h2 | t], [[ (h1-1)/2 + (h2-1)/2 | curr_lvl] | prev_lvls])
  defp spill(lvl, pos, [_h1, h2 | t], [curr_lvl | prev_lvls]) when h2 > 1, do: spill(lvl, pos + 1, [h2 | t], [[ (h2-1)/2 | curr_lvl] | prev_lvls])
  defp spill(lvl, pos, [h1, h2 | t], [curr_lvl | prev_lvls]) when h1 > 1, do: spill(lvl, pos + 1, [h2 | t], [[ (h1-1)/2 | curr_lvl] | prev_lvls])
  defp spill(lvl, pos, [h1, h2 | t], [curr_lvl | prev_lvls]) when h1 <= 1 and h2 <= 1, do: spill(lvl, pos + 1, [h2 | t], [[ 0 | curr_lvl] | prev_lvls])
end