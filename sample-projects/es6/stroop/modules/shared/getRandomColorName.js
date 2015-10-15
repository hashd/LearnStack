const names = Object.freeze([
  'yellow',
  'red',
  'blue',
  'green',
  'orange',
  'violet'
])

export default function getRandomColorName() {
  const idx = Math.ceil(Math.random() * names.length) - 1
  return names[idx]
}