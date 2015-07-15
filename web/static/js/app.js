import {Socket} from "phoenix"

class App {

  static init(){
  	let socket = new Socket("/ws", {
      logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }
    })
    socket.connect()
    var current_user_id = parseInt($('user').attr('data-id'))
    var chan = socket.chan("notifs:"+current_user_id, {})

  	chan.join()
  		.receive("ignore", e => console.log("auth error"))
  		.receive("ok", e => console.log("join ok"))

  	chan.on("new_msg", payload => console.log(payload) )

  	var $button = $("#wsbutton")

  	$button.on("click", function() {
  		console.log("test click")
  		chan.push("new_msg", {body: "HELLLLOOOO BUTTON"})
  	})

	}

}

$( () => App.init() )

export default App