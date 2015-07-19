defmodule KV.Bucket do
  @moduledoc """
  The key value bucket store
  """

  @doc """
  Starts a new bucket
  """
  def start_link do
    Agent.start_link fn -> HashDict.new end
  end

  def get(bucket, key) do
    Agent.get(bucket, fn (dict) -> HashDict.get(dict, key) end)
  end

  def put(bucket, key, value) do
    Agent.update(bucket, fn (dict) -> HashDict.put(dict, key, value) end)
  end

  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn (dict) -> HashDict.pop(dict, key) end)
  end
end