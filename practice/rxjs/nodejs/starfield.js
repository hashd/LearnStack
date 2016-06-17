'use strict'
const Rx = require('rxjs')

const SPEED = 40,
  STAR_NUMBER = 250,
  WIDTH = 500,
  HEIGHT = 500

let starStream = Rx.Observable.range(1, STAR_NUMBER)
  .map(d => ({
    x: parseInt(Math.random() * WIDTH),
    y: parseInt(Math.random() * HEIGHT),
    size: Math.random() * 3 + 1 })
  )
  .toArray()
  .flatMap(arr => Rx.Observable.interval(SPEED).map(() => arr.forEach(star => {
                      star.y = star.y >= HEIGHT ? 0 : star.y + 3
                      return star
                    }))
  )
  .forEach(console.log)

//starStream.subscribe(console.log)