'use strict'
const Rx = require('rxjs')

/*
let intStream = Rx.Observable.range(1, 10)

intStream
	.take(10)
	.filter(d => d % 2 == 0)
	.subscribe(d => console.log(d))

let aIntervalStream = Rx.Observable.interval(100).map(d => 'A' + d)
let bIntervalStream = Rx.Observable.interval(200).map(d => 'B' + d)

Rx.Observable.merge(aIntervalStream, bIntervalStream)
	.take(20)
	.subscribe(d => console.log(d))

intStream
  .scan((agg, val) => ({ sum: agg.sum + val, count: agg.count + 1}), { sum: 0, count: 0})
  .map(val => val.sum/val.count)
  .subscribe(d => console.log(d))*/

/*let infStream = Rx.Observable.interval(100)
let infStrSub = infStream.subscribe(i => console.log(i))

setTimeout(() => infStrSub.unsubscribe(), 2000)*/

/*let arrStream = Rx.Observable.from([1, 2, 3, 4, 5])
arrStream.map(d => d * d * d)
  .subscribe(console.log)*/

let intStream = Rx.Observable.interval(1000)
intStream
  .filter(d => d % 2 == 0)
  .scan((acc, d) => acc + 1, 0)
  .subscribe(console.log)