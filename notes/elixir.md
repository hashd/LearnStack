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





