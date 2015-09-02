import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

class App {
	static init(channel) {
		var username = prompt("Nickname: ");
		var socket = new Socket("/ws");
		socket.connect()
		socket.onClose(e => console.log("Closed connection"))

		var channel = socket.chan("rooms:" + channel, {user: username})	
		channel.join()
			.receive("ok", () => channel.push("new:user", {user: username}))
			.receive("error", () => console.log("Connection error"))
		
		channel.on("new:message", this.renderMessage)
		channel.on("new:user", this.renderNewUser)
		channel.on("bye:user", this.renderExitUser)
		channel.on("current:users", this.renderCurrentUsers)

		var msgBody = $("#message")
		msgBody.off("keypress")
			.on("keypress", e => {
			  if (e.keyCode == 13) {
			    channel.push("new:message", {
			    	user: username,
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

	static renderNewUser(msg) {
		$("#messages").append(`<p><b>[${msg.user}]</b> has joined.</p>`)
	}

	static renderExitUser(msg) {
		$("#messages").append(`<p><b>[${msg.user}]</b> has left.</p>`)
	}

	static renderCurrentUsers(msg) {
		$('#messsages').append(`<p>Currently online: <i>${msg.users.join(",")}</i></p>`)
	}
}

export default App
