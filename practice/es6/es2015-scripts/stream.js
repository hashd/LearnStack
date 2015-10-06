class Stream {
  static unfold(initial_state, func) {
    return {
      [Symbol.iterator]: function () {
        return {
          state: initial_state,
          next() {
            let [value, next_state] = func(this.state);
            this.state = next_state;
            return { value, done: false }
          }
        }
      }
    }
  }

  static cycle(enumerable) {
    return {
      [Symbol.iterator]: function () {
        return {
          enumerable,
          done: true,
          iterable: null,
          next() {
            if (this.done === true) {
              this.iterable = this.enumerable[Symbol.iterator]()
            }
            let { value, done } = this.iterable.next()
            this.done = done

            return { value: (this.done === true ? this.next().value : value), done: false}
          }
        }
      }
    }
  }

  static iterate(initial_value, func) {
    return {
      [Symbol.iterator]: function () {
        return {
          value: initial_value,
          next() {
            let value = this.value
            this.value = func(value)

            return { value, done: false }
          }
        }
      }
    }
  }

  static repeatedly(func) {
    return {
      [Symbol.iterator]: function () {
        return {
          fun,
          next() {
            return { value: this.fun(), done: false }
          }
        }
      }
    }
  }
}

/* Test Code */
let uf_count = 0, max_uf_count = 10
for (let fib of Stream.unfold([0, 1], ([a, b]) => [a, [b, a+b]])) {
  if (uf_count >= max_uf_count) break
  console.log(fib)
  uf_count++
}

let cy_count = 0, max_cy_count = 10
for (let ele of Stream.cycle([1,2,3,4,5])) {
  if (cy_count >= max_cy_count) break
  console.log(ele)
  cy_count++
}

let it_count = 0, max_it_count = 10
for (let val of Stream.iterate(2, d => d * 2)) {
  if (it_count >= max_it_count) break
  console.log(val)
  it_count++
}