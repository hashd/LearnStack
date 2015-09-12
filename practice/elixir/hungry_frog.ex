defmodule HungryFrog do
  @moves [{3, 0}, {-3, 0}, {0, 3}, {0, -3}, {2, 2}, {2, -2}, {-2, -2}, {-2, 2}]

  def resolve({xs, ys} = start, {w, h} = dimensions, board \\ HashDict.new, moves \\ @moves)
    when w > 0 and h > 0 and xs >= 0 and xs < w and ys >= 0 and ys < h and length(moves) > 0 do
      resolve(start, dimensions, board, moves, 1)
  end

  defp resolve({xs, ys} = start, {w, h} = dimensions, board, moves, move_number) do
    new_board = Dict.put(board, start, move_number)

    target_moves = moves
      |> Enum.map(fn {dx, dy} -> {xs + dx, ys + dy} end)
      |> Enum.filter(&(valid_move?(&1, dimensions, new_board)))

    case target_moves do
      [] -> new_board
      moves_list -> 
        best_move = target_moves
          |> Enum.max_by(&(move_degree(&1, dimensions, new_board, moves)))
        resolve(best_move, dimensions, new_board, moves, move_number + 1)
    end
  end

  defp valid_move?({x, y}, {w, h}, board) when x >= 0 and x < w and y >= 0 and y < h do
    Dict.get(board, {x, y}) == nil
  end
  defp valid_move?({_x, _y}, {_w, _h}, board), do: false

  defp move_degree({x, y} = point, dimensions, board, moves) do
    moves
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(&(valid_move?(&1, dimensions, board)))
    |> length
  end

  def solution({x, y} = start, {w, h} = dimensions) do
    board = resolve(start, dimensions)

    board
    |> Dict.keys
    |> Enum.map(&({&1, Dict.get(board, &1)}))
    |> Enum.sort_by(fn {k, v} -> v end)
  end
end