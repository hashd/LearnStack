const methodLog = (target: Object, key: string | symbol, descriptor: TypedPropertyDescriptor<Function>): any => {
  return {
    value: function(...args: any[]) {
      console.log('Arguments: ', ...args)
      const result = descriptor.value.apply(this, args)
      console.log('Result: ', result)
      return result
    }
  }
}

class Kid {
  name: string

  constructor(name: string) {
    this.name = name
  }

  @methodLog
  greet(name: string, message: string) {
    console.log(this.name)
    return `${this.name} says to ${name}: ${message}`
  }
}

const kid = new Kid("Georgie")
kid.greet("Edward", "Hello")