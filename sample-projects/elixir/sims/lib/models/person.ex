defmodule Models.Person do
  defstruct name: nil, age: 2, gender: :male, current_task: :rest, stamina: 100

  def start_link do
    Agent.start_link(fn -> %__MODULE__{} end) 
  end

  def get(person, :state) do
    Agent.get(person, fn state -> state end)
  end

  def update(person, atom, age) when is_atom(atom) do
    Agent.get_and_update(person, fn state -> 
      new_state = Map.put(state, atom, age)
      {new_state, new_state}
    end)
  end

  def chat(person) when is_pid(person) do
    Agent.cast(person, __MODULE__, :chat, [get(person, :state)])
  end

  def chat(state) do
    receive do
      {message, sender} -> 
        IO.puts "Received message: #{message} from #{sender}"
        send(sender, {:DND, self})
    end
    chat state
  end
end