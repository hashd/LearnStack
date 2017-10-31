const log = <T extends {new(...args:any[]):any}>(Constructor: T) => {
  return class extends Constructor {
    constructor(...args: any[]) {
      super(...args)

      console.log('Arguments: ', ...args)
    }
  }
}

@log
class Person {
  constructor(name: string, age: number, gender: string) {}
}

new Person("Kiran", 29, "Male")