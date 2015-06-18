> Most programmers treat threads and processes as a necessary evil. Elixir developers feel they are an important simplification.

## Conventional Programming

### Pattern Matching
In Elixir, the equal sign is not an assignment, it's like an assertion. It succeeds if Elixir can find a way of making the left-hand side equal the right hand side. Elixir calls `=` a *match operator*.

Elixir will only change the value of a variable on the left hand side of an equals sign - on the right a variable is replaced with its value.

```
iex> list = ['a', 'b', 'c']
['a', 'b', 'c']
iex> [a, b, c] = list
['a', 'b', 'c']
iex> a
'a'
iex> b
'b'
```

Elixir looks for a way to make the value of the left side the same as on the right. This process is called *pattern matching*. A pattern is matched if:

- Values on both sides have the same structure 
- Literal value in the pattern matches that exact value
- Variable in the pattern matches by taking on the corresponding value

> `_` acts like a variable but immediately discards any value given to it in a pattern match.

Once a variable has been bound to a value in the matching process, it keeps that value for the remainder of the match. However, a variable can be bound to a new value in a subsequent match, and its current value doesnt participate in the new match.

If we want Elixir to force the variable to use existing value we could prefix it with `^` (caret).

```
iex(19)> a = 1
1
iex(20)> [1, ^a] = [1,2]
** (MatchError) no match of right hand side value: [1, 2]
```

### Immutability
Elixir enforces immutable data.

> GOTO was evil because we asked 'How did I get to this point of execution'. Mutability leaves us with, 'How did I get to this state'?

In Elixir, once a variable references a list such as ['a', 'b', 'c'], it will always reference those same values until its is rebinded to another value. Any mutating operation on any object results in a new object and the original remains unchanged. This fits in nicely with the idea that programming is about transforming data.

#### Performance implications of Immutability

##### Copying Data
Because Elixir knows that existing data is immutable, it can reuse it, in part or as a whole, when building new structures.

```
iex> listA = ['a', 'b', 'c']
['a', 'b', 'c']
iex> listB = [' ' | listA]
[' ', a', 'b', 'c']
```

##### Garbage Collection
Elixir programs uses lots and lots of processes and each process has its own heap. The data in the applicated is divided between these processes, so each individual heap is much, much smaller than would have been the case if all the data has been in a single heap.

#### Coding with Immutable Data
In a functional language, we always transform data. We never modify it in place. The syntax reminds us of this every time we use it.

## Elixir Basics

### Built-in types

- Value types
	+ Arbitrary-sized integers
	+ Floating-point numbers
	+ Atoms
	+ Ranges
	+ Regular Expressions
- System types
	+ PIDs and ports
	+ References
- Collection types
	+ Tuples
	+ Lists
	+ Maps
	+ Binaries

#### Integers
Integer literals can be written as decimal(`1234`), hexadecimal(`0xcafe`), octal(`0o7654`) and binary (`0b10101`). There is no fixed limit on the size of integers.

#### Floating-point Numbers
Floating-point numbers are written using a decimal point and there must be at least one digit after and before the decimal point.

Floats are IEEE754 double precision, giving them about 16 digits of accuracy and a maximum exponent of around 10^308.

#### Atoms
Atoms are constants that represent something's name. It precedes wihs a colon `:`, which can be followed by an atom word or an Elixir operator.

`:name :address :is_adult? :var@A :<> :=== :"func/3" :"your name is siri"`

> An atom word is a sequence of letters, digits, underscores and at signs. It may end with an exclamation point or a question mark.

An atom's name is its value. Two atoms with the same name will always compare as being equal, even if they were created by different applications on different machines.

#### Ranges
Ranges are represented as `start..end`, where `start` and `end` can be values of any type. However, if one wants to iterate over the values in a range, the two extremes must be integers.

#### Regular Expressions
Elixir has regular-expression literals, written as `~r{regexp}` or `~r{regexp}opts`. The delimiters `{}` is flexible and thus any nonalphanumeric character can be used as a delimiter.

```
iex> Regex.run ~r{[aeiou]}, "caterpillar"
["a"]        
iex> Regex.scan ~r{[aeiou]}, "caterpillar"
[["a"], ["e"], ["i"], ["a"]]
iex> Regex.split ~r{[aeiou]}, "caterpillar"
["c", "t", "rp", "ll", "r"]
iex> Regex.replace ~r{[aeiou]}, "caterpillar", "*"
"c*t*rp*ll*r"
```
#### PIDs
A PID is a reference to a local or remote process, and a port is a reference to a resource external to the application.

> PID of the current process is available by calling `self`.

#### References
The function `make_ref` creates a globally unique reference; no other reference will be equal to it.

**Elixir collections can hold values of any type, including other collections**.

#### Tuples
Tuple is an ordered collection of values. Once created, a tuple cannot be modified. A tuple is written as a series of values between braces, separated with commas:

` {1,2} {:ok, 42, "next"} {:error, :enoent} `

A typical tuple has two to four elements, one can use `map`s or `struct`s otherwise.

Tuples can be used in pattern matching. It is pretty common to return tuples from functions.

```
iex> {status, count, action} = {:ok, 42, "next"}
{:ok, 42, "next"}
iex> status  
:ok          
iex> count   
42
```

#### Lists
List is effectively a linked data structure and may either be empty or consist of a head and a tail list. Because of their implementation, lists are easy to traverse linearly, but they are expensive to access in random order.

Lists are also immutable in nature so any mutating action of list will return a new list.

```
iex>  [ 1, 2, 3 ] ++ [ 4, 5, 6 ]      # concatenation
[1, 2, 3, 4, 5, 6]
iex> [1, 2, 3, 4] -- [2, 4]           # difference
[1, 3]       
iex> 1 in [1,2,3,4]                   # membership
true         
iex> "wombat" in [1, 2, 3, 4]
false
```

##### Keyword Lists
Elixir gives us a shortcut to write simple list of key/value pairs.

```
[ name: "Siri", desc: "Voice Assistant", origin: "Labs" ]
```

Elixir converts it into `[{:name, "Siri"}, {:desc, "Voice Assistant"}, {:origin, "Labs"}]`

Elixir also allows us to omit the square brackets if a keyword list appears as the last item in any context where a list of values is expected.

#### Maps
A map is a collection of key/value pairs. A map literal looks like this: `%{ keyA => valueA, keyB => valueB,  keyC => valueC}`

> Although typically all the keys in a map are the same type, that isn't required.

If the key is an atom, one can use the same shortcut as keyword lists

```
iex> colors = %{ red: 0xff0000, green: 0x00ff00, blue: 0x0000ff }
%{blue: 255, green: 65280, red: 16711680}
```

Maps allow only one entry for a particular key, whereas keyword lists allow the key to be repeated. Maps are efficient and they can be used in Elixir's pattern matching.

> Use keyword lists for things such as command-line parameters and for passing around options, and use maps (or another data structure, the HashDict) when you want an associative array.

##### Accessing a Map
One can extract values from a map using the key. The square bracket syntax works with all maps:

```
iex>value = map[$key]
```

> Map returns `nil` if the key doesn't have an associated value.

If the keys are atoms, you can use the dot notation like `colors.green`

#### Binaries
[TODO](#TODO)

### Conventions
Identifiers in Elixir are combinations of upper and lowercase ASCII characters, digits and underscores. It may end with a question mark or exclamation.

Module, record, protocol and behaviour names start with an uppercase letter and are `BumpyCase`.

It the first character is an underscore, Elixir doesn't report a warning if the variable is unused in a pattern match or function parameter list.

Source file uses two-character indentation for nesting and use spaces, not tabs, to achieve this.

Comments start with a hash sign `#` and run to the end of the line.

### Truth
Elixir has three special values: `true`, `false` and `nil`. `nil` is treated as false in Boolean Contexts.

> All three of them are aliases for atoms of the same name.

In most contexts, any value other than `false` or `nil` is treated as `true`.

## Anonymous Functions
An anonymous function is created using the `fn` keyword:

```
fn
	parameter-list -> body
	parameter-list -> body
	parameter-list -> body
end
```

At its simplest, a function has a parameter list and a body separated by `->`.

```
iex> mul = fn (a, b) -> a * b end
iex> mul.(2, 3)
6
```

The function is invoked using the the syntax var.(parameter-list). The dot indicates the function call, and the arguments are passed between parenthesis.

> The dot is not needed for named function calls but required for anonymous function calls.

If the function takes no arguments, you still need the parenthesis to call it however, one can omit the parentheses in a function definition.

```
iex> mul = fn a, b -> a * b end
iex> mul.(3, 4)
12
```

#### One Function, Multiple Bodies
A single function definition lets you define different implementations, depending on the type and contents of the arguments passed.

> It can't be selected based on the number of arguments, each clause in the function definition must have the same number of parameters.

> Inside a string, the contents of `#{...}` are evaluated and the result is substituted back in.

#### Functions can return functions

```
iex> mul = fn a -> fn b -> a * b end end
iex> mul.(4).(5)
20
iex> fourMultiplier = mul.(4)
iex> fourMultiplier.(5)
20
```

Functions in Elixir automatically carry with them the bindings of variables in the scope in which they are defined. This is commonly termed as `*closure*`.

#### Passing functions as Arguments
Functions are just values, so they can be passed to other functions as arguments.

```elixir
fourMultiplier = fn x -> 4 * x end
apply = fn fun, value -> fun.(value) end
apply.(fourMultiplier, 5)
```

#### The & Notation
The strategy of creating short helper functions is so common that Elixir provides a shortcut.

```elixir
square = &(&1*&1)
square.(5)
```

The & operator converts the expression that follows into a function. Inside the expression, the placeholders &1, &2 and so on correspond to the first, second and subsequent parameters to the function.

Elixir can reuse some of the existing functions while creating references to these functions, the arguments must also be in the correct order.

Because [] and {} are operators in Elixir for lists and tuples, they can also be turned into functions.

```elixir
divrem = &{ div(&1, &2), rem(&1, &2) }
divrem.(22, 7)
{3, 1}
```

The & shortcut gives us a wonderful way to pass functions to other functions.

```Elixir
iex> Enum.map [1,2,3,4], &(&1 + 1)
[2, 3, 4, 5] 
iex> Enum.map [1,2,3,4], &(&1 * &1)
[1, 4, 9, 16]
iex> Enum.map [1,2,3,4], &(&1 < 3)
[true, true, false, false]
```

Functions are the heart of Elixir.

## Modules and Named Functions
In Elixir, **named functions** must be written within **modules**.

```elixir
defmodule Module do
	def sum(a,b) do
		a + b
	end
end
```

Modules can be compiled and loaded by running `$iex filepath` from the command prompt or `iex> c filepath` from the interactive elixir shell.

In Elixir, a named function is identified by both its name and its arity. Functions with same name and different arity are totally separate as far as Elixir is concerned.

> `do..end` block is one way of grouping expressions and passing them to other code.

The actual syntax for writing functions is `def fun(params), do: params+1`. Multiple lines can be passed by grouping them with parentheses `()`. The `do..end` is just syntactic sugar.

### Function Calls and Pattern Matching
When you call a named function, Elixir tries to match your arguments with the parameter list of the first definition (clause). If it cannot match them, it tries the next definition of the same function (remember, this must have the same arity) and checks to see if it matches. It continues until it runs out of candidates.

```elixir
defmodule Fibonacci do
	def at(0), do: 1
	def at(1), do: 1
	def at(n), do: at(n-1) + at(n-2)
end
```

> The order of these clauses can make a difference when you translate them into code. Elixir tries functions from the top down, executing the first match.
> Multiple implementations of the same function, should be adjacent in the source file.

### Guard Clauses
These are predicates that are attached to a function definition using one or more when keywords. When doing pattern matching, Elixir first does the conventional parameter-based match and then evaluates any when predicates, executing the function only if at least one predicate is true.

```elixir
defmodule Factorial do
	def of(0), do: 1
	def of(n) when n > 0, do: n * of(n-1)
end
```

#### Guard-Clause Limitations
Only a subset of Elixir expressions can be used in guard clauses which can be seen in the official guide.

### Default Parameters
```elixir
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end        
end

defmodule Params do
  def func(p1, p2 \\ 123)
  def func(p1, p2) when is_list(p1)  do
    "You said #{p2} with a list"
  end        
  def func(p1, p2) do
    "You passed in #{p1} and #{p2}"
  end        
end
```

### Private Functions
The `defp` macro defines a private function, one that can be called only within the module that declares it.

> One cannot have some heads of the function private and others public when the arity is same.

### `|>` - Pipe Operator
The |> operator takes the result of the expression to its left and inserts it as the first parameter of the function invocation to its right.

`val |> function(a, b)` is basically the same as calling `function(val, a, b)` and `list |> sales_tax(2013) |> prepare_filing` is same as writing `prepare_filing(sales_tax(list,2013))`.

> Programming is transforming data, and the `|>` operator makes that transformation explicit.

### Modules
Modules provide namespaces for things we define. Nested modules are used to impose structure for readability and reuse.

To access a function in a nested module from the outside scope, prefix it with all the module names. To access it within the containing module, use either the fully qualified name or just the inner module name as a prefix.

```elixir
defmodule Outer do
  defmodule Inner do
    def inner_func do
    end      
  end        
  def outer_func do
    Inner.inner_func
  end        
end
```

> Module nesting in Elixir is an illusion—all modules are defined at the top level. When we define a module inside another, Elixir simply prepends the outer module name to the inner module name, putting a dot between the two.

#### Directives for Modules
Elixir directives are **lexically** scoped. A directive in a module definition takes effect from the place one has written till the end of the module. A directive in a function definiton runs to the end of the function.

##### `import` Directive
The import directive brings a module’s functions and/or macros into the current scope.

`import Module [, only:|except: ]`

##### `alias` Directive
The alias directive creates an alias for a module.

`alias ModuleName.SubModule, as: Alias`

> `as:` parameter defaults to the last part of the module name.

##### `require` Directive
`require` directive ensures that the given module is loaded before your code tries to use any of the macros it defines

#### Module Attributes
Elixir modules each have associated metadata. Each item of metadata is called an attribute of the module and is identified by a name. Inside a module, you can access these attributes by prefixing the name with an at sign (@).

```elixir
defmodule ModuleName do
	@owner "hashd"
	def get_owner do
		@owner
	end
end
```

> These attributes are not variables in the conventional sense. Use them for configuration and metadata only.

#### Module Names: Elixir, Erlang and Atoms
Internally, module names are just atoms. When you write a name starting with an uppercase letter, such as `MyModule`, Elixir converts it internally into an atom called Elixir.MyModule.

```elixir
defmodule MyModule do
end
is_atom MyModule
to_string MyModule
:"Elixir.MyModule" === MyModule
```

In Erlang, variables start with an uppercase letter and atoms are simple lowercase names. In Elixir atoms are prefixed with `:`. In Elixir, we simply change the Erlang module names to an Elixir atom.

Native modules for Elixir are documented on the Elixir website and the others can be found listed at [Hex PM](http://hex.pm) and on Github.

## Lists and Recursion

### Heads and Tails
A list may either be empty or consist of a head and a tail. The head contains a value and the tail itself is another list. 

```elixir
[ a | [ b | [ c | [ d | [] ] ] ] ]
[ a, b, c, d ]
```

The pipe character can also be used in pattern matching

```elixir
[ a | b ] = [ 100, 101, 102, 103, 104 ]
iex> a
100
iex> b
[101,102,103,104]
```

> Note that if all the values in a list represent printable characters, it displays the list as a string; otherwise it displays a list of integers.

```elixir
defmodule MyList do
	def map([], _), do: []
	def map(min..max, fun), do: map(Enum.to_list(min..max), fun)
	def map([head | tail], fun), do: [fun.(head) | map(tail, fun)]
end
```

The Join Operator `|` supports multiple values to the left.

```elixir
[ a, b, c, d | [ e, f, g] ]
[ a, b, c, d, e, f, g]
```

> This works in pattern matching too.

### List module in action








