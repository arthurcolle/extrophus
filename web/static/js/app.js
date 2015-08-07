import {Socket} from "deps/phoenix/web/static/js/phoenix"
import "deps/phoenix_html/web/static/js/phoenix_html"


// import {Socket} from "phoenix"

// class App {

//   static init(){
//   	let socket = new Socket("/ws")
//     socket.connect({logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data) }})
//     var current_user_id = parseInt($('user').attr('data-id'))
//     var chan = socket.channel("notifs:"+current_user_id, {})

//   	chan.join()
//   		.receive("ignore", e => console.log("received ignore on channel (auth error)"))
//   		.receive("ok", e => console.log("received ok on channel (join ok)"))

//   	chan.on("new_msg", payload => {
//       console.log("Channel received new_msg, here is payload: \n" + payload.body) 
//       var oldval = $('#notifs').val()
//       console.log(oldval)
//       if (oldval == "") {
//         oldval = 0
//       }
//       else {
//         oldval = parseInt(oldval) + 1
//       }
//       console.log(oldval)
//       $('#notifs').empty()
//       $.ajax({
//         type: "GET",
//         url: "/unread/"+current_user_id,
//         success: function(data) {
//           console.log("unread messages: " + data["unread"])
//           $('#notifs').append(data["unread"])
//         }
//       })

//     })

//   	var $button = $("#wsbutton")

//   	$button.on("click", function() {
//   		console.log("test click")
//   		chan.push("new_msg", {body: "HELLLLOOOO BUTTON"})
//   	})

// 	}

// }

// $( () => App.init() )

// export default App