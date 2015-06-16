function addStripeInformation(data) {
  var handler = StripeCheckout.configure({
    // key: 'pk_test_k90DPHCGKmfYhYa5anVRrVKy',
    key: 'pk_live_Q43jYi6k0EatjdmDkVYivYQY',
    token: function(token) {
      $.ajax({
        url: '/charges/create',
        type: "POST",
        data: {
          "token" : token.id,
          "email" : data.email
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

connect = function() {
  $.ajax({
    url: '/connect',
    type: "GET"
  });
  $('#modal1').openModal()
}



execute = function() {
  var country = $('.country').val();
  var tos = $("input[name='tos']:checked").val();
  console.log(country);
  console.log(tos);
  $.ajax({url: "accepted_tos", type: "POST", data: {"country": country, "tos": tos}});
  $('#modal1').closeModal();
  $("#modal2").openModal();
}

execute2 = function() {
  var legal_entity_first_name = $("input[name='legal_entity[first_name]']").val();
  var a = legal_entity_first_name;
  var legal_entity_last_name = $("input[name='legal_entity[last_name]']").val();
  var b = legal_entity_last_name;
  var legal_entity_dob_a = $("select[name='legal_entity[dob(1i)]']").val();
  var c = legal_entity_dob_a;
  var legal_entity_dob_b = $("select[name='legal_entity[dob(2i)]']").val();
  var d = legal_entity_dob_b;
  var legal_entity_dob_c = $("select[name='legal_entity[dob(3i)]']").val();
  var e = legal_entity_dob_c;
  var legal_entity_address_line_a = $("input[name='legal_entity[address][line1]']").val();
  var f = legal_entity_address_line_a;
  var legal_entity_address_line_b = $("input[name='legal_entity[address][line2]']").val();
  var g = legal_entity_address_line_b;
  var legal_entity_address_city = $("input[name='legal_entity[address][city]']").val();
  var h = legal_entity_address_city;
  var legal_entity_address_state = $("input[name='legal_entity[address][state]']").val();
  var i = legal_entity_address_state;
  var legal_entity_address_zip = $("input[name='legal_entity[address][postal_code]']").val();
  var j = legal_entity_address_zip;
  var account_number = $("input[data-stripe='account_number']").val();
  var k = account_number;
  var routing_number = $("input[data-stripe='routing_number']").val();
  var m = routing_number;
  var secure_form = [a,b,c,d,e,f,g,h,i,j,k,m];
  console.log(secure_form);
  console.log(country_code + " is great");
  Stripe.bankAccount.createToken({
      country: country_code,
      routingNumber: routing_number,
      accountNumber: account_number,
  }, function(status, response) {
      if (response.error) {
          console.log(response);
          alert(response.error.message);
      } else {
          var token = response.id;
          var dt = {
              "token" : token,
              "first_name": a,
              "last_name": b,
              "dob1": c,
              "dob2": d,
              "dob3": e,
              "address1": f,
              "address2": g,
              "address_city": h,
              "address_state": i,
              "address_zip": j
          };
          $.ajax({url: "create_connected", type: "POST", data: dt});
      }
  });
}