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

Internally defmodule, def, if and most of ExUnit keywords are implemented as macros in Elixir.

Macros allows one to extend the language with one's own keywords while using existing macros as building blocks.



