defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 10
  @moduledoc """
  CLI Input Handler
  """

  def main(argv) do
    argv |> parse_args |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      { [help: true], _, _ } -> :help
      { _, [user, project, count], _} -> { user, project, count |> String.to_integer }
      { _, [user, project ], _} -> {user, project, @default_count}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt 0
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project) |> 
      decode_response |> 
      convert_to_list_of_hashdicts |>
      sort_into_ascending_order |>
      Enum.take(count) |>
      print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = error |> List.keyfind("message", 0)
    IO.puts "Error fetching issues from Github: #{message}"
    System.halt 0
  end

  def convert_to_list_of_hashdicts(list) do
    list |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues, fn i1, i2 -> i1["created_at"] >= i2["created_at"] end
  end
end