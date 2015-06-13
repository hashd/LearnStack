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


