import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

class App {
	static init() {
		var socket = new Socket("/ws");
		socket.connect()
		socket.onClose(e => console.log("Closed connection"))

		var channel = socket.chan("rooms:lobby", {})
		channel.join()
			.receive("ok", () => console.log("Connected"))
			.receive("error", () => console.log("Connection error"))
		
		channel.on("new:message", this.renderMessage)
		
		var username = $("#username")
		var msgBody  = $("#message")

		msgBody.off("keypress")
			.on("keypress", e => {
			  if (e.keyCode == 13) {
			    channel.push("new:message", {
			    	user: username.val(),
			    	body: msgBody.val()
			    })
			    msgBody.val("")
			  }
			});
	}

	static renderMessage(msg) {
	  var messages = $("#messages")
	  messages.append(`<p><b>[${msg.user}]</b>: ${msg.body}</p>`)
	}
}

$(() => App.init())	

export default App
