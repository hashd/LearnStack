const addDeck = (name) => ({ type: 'ADD_DECK', data: name })
const showAddDeck = () => ({ type: 'SHOW_ADD_DECK' })
const hideAddDeck = () => ({ type: 'HIDE_ADD_DECK' })

const cards = (state, action) => {
  switch (action.type) {
    case 'ADD_CARD':
      let newCard = Object.assign({}, action.data, {
        score: 1,
        id: +new Date()
      })

      return state ? state.concat([newCard]): [newCard]

    default:
      return state || []
  }
}

const decks = (state, action) => {
  switch (action.type) {
    case 'ADD_DECK':
      let newDeck = { name: action.data, id: +new Date() }
      return state.concat([newDeck])
    default:
      return state || []
  }
}

const addingDeck = (state, action) => {
  switch (action.type) {
    case 'SHOW_ADD_DECK': return true
    case 'HIDE_ADD_DECK': return false
    default: return !!state
  }
}

const store = Redux.createStore(Redux.combineReducers({ cards, decks, addingDeck }))

const App = (props) => {
  return <div>{props.children}</div>
}

const Sidebar = React.createClass({
  render() {
    const props = this.props
    return (<div className="sidebar">
      <h2>All Decks</h2>
      <ul>
        { props.decks.map((deck, i) => <li key={i}>{deck.name}</li>) }
        { props.addingDeck && <input ref='add' /> }
      </ul>
    </div>)
  }
})

function run() {
  let state = store.getState()

  ReactDOM.render(<App>
    <Sidebar decks={state.decks} addingDeck={state.addingDeck}></Sidebar>
  </App>, document.getElementById('root'))
}

run()

store.subscribe(run)

window.showAddDeck = () => { store.dispatch(new showAddDeck()) }
window.hideAddDeck = () => { store.dispatch(new hideAddDeck()) }
window.addDeck = (name) => { store.dispatch(new addDeck(name || new Date().toString()))}

window.addDeck('Chapter 1')
window.addDeck('Chapter 2')
window.addDeck('Chapter 3')

// store.subscribe(() => {
//   console.log(store.getState())
// })

// store.dispatch({ type: 'ADD_CARD', data: { front: '', back: '' }})
// store.dispatch({ type: 'ADD_CARD', data: { front: '', back: '' }})