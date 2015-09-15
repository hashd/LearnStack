import strutils

proc getAlphabets(): string = 
  var acc = ""
  for alpha in 'a'..'z':
    acc.add(alpha)
  return acc

proc do_operation(operator: string, a: int, b: int): int =
  if operator == "+":
    result = a + b
  elif operator == "-":
    result = a - b
  elif operator == "*":
    result = a * b
  else:
    result = a div b

proc fib_of(n: int): int =
  case n
  of 0, 1: n
  else: fib_of(n-1) + fib_of(n-2)

proc gcd(a, b: int): int =
  if a == 0 or b == 0:
    a or b
  else:
    gcd(b, a mod b)

echo do_operation("+",5,10)
for n in 0..10:
  echo fib_of n
  echo "GCD of $1 and $2: $3" % ["5", $n, $(gcd(n, 5))]