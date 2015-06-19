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

function addStripeInformation(data) {
  console.log("hey");
  var handler = StripeCheckout.configure({
    key: 'pk_test_k90DPHCGKmfYhYa5anVRrVKy',
    // key: 'pk_live_Q43jYi6k0EatjdmDkVYivYQY',
    token: function(token) {
      $.ajax({
        url: '/users/customer',
        type: "POST",
        beforeSend: function(xhr) {
          xhr.setRequestHeader('x-csrf-token', '<%= get_csrf_token() %>')
        },
        data: {
          "token" : token.id,
          "email" : data.email
        },
        success: function(data, e) {
          console.log(data);
        }
      });
    }
  });


  $(function(){
    // Open Checkout with further options
    handler.open({
      email: data.email,
      name: data.name,
      description: 'You\'ll be eating before you know it',
      zipCode: false,
      panelLabel: "Add Information",
      allowRememberMe: false
    });
  });

  // Close Checkout on page navigation
  $(window).on('popstate', function() {
    handler.close();
  });
}


$(function() {
  /* event listener for ADD CARD button click */
  $("#addcard").on("click", function() {
    var name = $('#addcard').attr('data-name');
    var email = $('#addcard').attr('data-email');
    addStripeInformation({'name' : name, 'email' : email});
  });
});

