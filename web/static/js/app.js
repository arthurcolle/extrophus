import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

let App = {
}

export default App

	$("form#login").on("ajax:success", function(){
	  window.location = "/" // redirect wherever you want to after login
	}).on("ajax:error", function(){
	  $(".alert-danger").html("Unable to login.");
	});