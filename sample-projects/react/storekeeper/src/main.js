import React from 'react'
import ReactDOM from 'react-dom'

class Header extends React.Component {
  render() {
    return <h1 style={{color:'red'}}>{this.props.children}</h1>
  }
}

class Greeter extends React.Component {
  render() {
    return <Header>Hello, {this.props.name}!</Header>
  }
}

class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = { name: "hashd" }
  }

  render() {
    return <div>
      <Greeter name={this.state.name} />
      <input type="text" ref="name" />
      <button onClick={this.handleGreet.bind(this)}>Greet!</button>
    </div>
  }

  handleGreet() {
    this.setState({ name: this.refs.name.getDOMNode().value })
  }

  componentWillMount() {
    alert("About to mount <App />")
  }

  componentDidMount() {
    alert("Mounted <App />")
  }
}

ReactDOM.render(<App />, document.querySelector("#app"))