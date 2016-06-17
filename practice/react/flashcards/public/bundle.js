(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

var addDeck = function addDeck(name) {
  return { type: 'ADD_DECK', data: name };
};
var showAddDeck = function showAddDeck() {
  return { type: 'SHOW_ADD_DECK' };
};
var hideAddDeck = function hideAddDeck() {
  return { type: 'HIDE_ADD_DECK' };
};

var cards = function cards(state, action) {
  switch (action.type) {
    case 'ADD_CARD':
      var newCard = Object.assign({}, action.data, {
        score: 1,
        id: +new Date()
      });

      return state ? state.concat([newCard]) : [newCard];

    default:
      return state || [];
  }
};

var decks = function decks(state, action) {
  switch (action.type) {
    case 'ADD_DECK':
      var newDeck = { name: action.data, id: +new Date() };
      return state.concat([newDeck]);
    default:
      return state || [];
  }
};

var addingDeck = function addingDeck(state, action) {
  switch (action.type) {
    case 'SHOW_ADD_DECK':
      return true;
    case 'HIDE_ADD_DECK':
      return false;
    default:
      return !!state;
  }
};

var store = Redux.createStore(Redux.combineReducers({ cards: cards, decks: decks, addingDeck: addingDeck }));

var App = function App(props) {
  return React.createElement(
    'div',
    null,
    props.children
  );
};

var Sidebar = React.createClass({
  displayName: 'Sidebar',
  render: function render() {
    var props = this.props;
    return React.createElement(
      'div',
      { className: 'sidebar' },
      React.createElement(
        'h2',
        null,
        'All Decks'
      ),
      React.createElement(
        'ul',
        null,
        props.decks.map(function (deck, i) {
          return React.createElement(
            'li',
            { key: i },
            deck.name
          );
        }),
        props.addingDeck && React.createElement('input', { ref: 'add' })
      )
    );
  }
});

function run() {
  var state = store.getState();

  ReactDOM.render(React.createElement(
    App,
    null,
    React.createElement(Sidebar, { decks: state.decks, addingDeck: state.addingDeck })
  ), document.getElementById('root'));
}

run();

store.subscribe(run);

window.showAddDeck = function () {
  store.dispatch(new showAddDeck());
};
window.hideAddDeck = function () {
  store.dispatch(new hideAddDeck());
};
window.addDeck = function (name) {
  store.dispatch(new addDeck(name || new Date().toString()));
};

window.addDeck('Chapter 1');
window.addDeck('Chapter 2');
window.addDeck('Chapter 3');

// store.subscribe(() => {
//   console.log(store.getState())
// })

// store.dispatch({ type: 'ADD_CARD', data: { front: '', back: '' }})
// store.dispatch({ type: 'ADD_CARD', data: { front: '', back: '' }})

},{}]},{},[1]);
