'use strict'
const Rx = require('rxjs')

const subject = new Rx.Subject()
const source = Rx.Observable.interval(300)
                .map(v => `Interval message #${v}`)
                .take(5)

source.subscribe(subject)

const subscription = subject.subscribe(
  function onNext(x) { console.log('onNext: ' + x); },
  function onError(e) { console.log('onError: ' + e.message); },
  function onCompleted() { console.log('onCompleted'); }
)

subject.next('Our message #1')
subject.next('Our message #2')

setTimeout(() => subject.complete(), 1000)