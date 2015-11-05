# Metaprogramming Elixir

To write macros in Elixir, one needs to understand to essential concepts of Elixir's metaprogramming system and how they fit together.

### Abstract Syntax Tree
When your programs are compiled or interpreted, their source is transformed into a tree structure before being turned into bytecode or machine code. This process is usually masked away.

Elixir exposes the AST in a form that can be represented by Elixir's own data structures and gave us a natural syntax to interact with it.

One interacts with Elixir's AST at every step of the metaprogramming process. The AST representation of any Elixir expression by using the quote macro. Code generation relies heavily on `quote`.

``` elixir
iex> quote do: 1 + 2
{:+, [context: Elixir, import: Kernel], [1, 2]}
```

Quoting expressions gives you something that you've probably never seen from a language before: the ability to peer into the internal representation of your code, within a data structure you already know and understand. This lets you infer meaning, optimize performance or extend functionality while staying within Elixir's high-level syntax.

### Macros
Macros are code that writes code. Their purpose is to interact with the AST using Elixir's high-level syntax.

Macros are used for everything from building Elixir's standard library to serving as core infrastructure of a web framework. Elixir macros let you write simple code with high performance.

Internally `defmodule`, `def`, `if` and most of ExUnit keywords are implemented as macros in Elixir.

Macros allows one to extend the language with one's own keywords while using existing macros as building blocks.

#### First Macro
Checkout **practice/elixir/macros/math.exs**

## Macro Rules

#### Rule 1: Don't write Macros
It's easy to get caught in our own web of code generation, and many have been bitten by reckless complexity. When taken too far, macros can make programs difficult to debug and reason about.

#### Rule 2: Use Macros Gratuitously

### The Abstract Syntax Tree - Demystified
Truly understanding the AST is essential as you get into advanced metaprogramming. Once we uncover the nuances, you'll find that your Elixir code is much closer to the AST than you might have imagined.

#### Structure of AST
Every expression you write in Elixir breaks down to a 3-element tuple in the AST. This uniform breakdown can be taken advantage of when pattern matching arguments in macros.

- The first element is an atom denoting the function call, or another tuple, representing a nested node in the AST
- The second element represents metadata about the expression
- The third element is a list of arguments for the function call

With Lisp, you have all the power of a programmable AST at the cost of a less natural and flexible syntax. José’s revolutionary insight was to separate the syntax from the AST. In Elixir, you get the best of both worlds: a programmable AST with a high-level syntax to perform all the work.

Several literals in Elixir have the same representation within the AST and high-level source. This includes atoms, integers, floats, lists, strings and any two element tuples containing the former types.

## Macros: The Building Blocks of Elixir

``` elixir
defmodule ControlFlow do
	defmacro unless(expression, do: block, else: else_block) do
		quote do
			if !unquote(expression), do: unquote(block), else: unquote(else_block)
		end
	end
end
```





