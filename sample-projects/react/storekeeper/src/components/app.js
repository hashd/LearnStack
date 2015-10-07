import React from 'react'
import ReactDOM from 'react-dom'
import MainHeader from './main_header'
import Page from './page'

class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = { name: "hashd" }
  }

  render() {
    return <div>
      <MainHeader />
      <Page pageTitle="Orders">
        <div>Hi, this is sample text</div>
      </Page>
    </div>
  }

  handleGreet() {
    this.setState({ name: this.refs.name.getDOMNode().value })
  }
}

export default App