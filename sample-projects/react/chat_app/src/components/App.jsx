import React from 'react'

class App extends React.Component {
	constructor() {
		super()
		this.state = {
			messages: [
				'Hi idiot, how are you?',
				'I am fine, and you?'
			]
		}
	}

	render() {
		var messageNodes = this.state.messages.map(message => {
			return (
				<p>{message}</p>
			)
		})

		return (
		  <div>{messageNodes}</div>
		)
	}
}

export default App