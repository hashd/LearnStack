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






