defmodule SequenceServer do
  use GenServer

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:set_number, number}, _current) do
    {:noreply, number}
  end
end