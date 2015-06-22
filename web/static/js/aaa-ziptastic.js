(function( $ ) {
  var requests = {};
  var zipValid = {
    us: /[0-9]{5}(-[0-9]{4})?/
  };

  $.ziptastic = function(country, zip, callback){
    // If only zip and callback are given default to US
    if (arguments.length == 2 && typeof arguments[1] == 'function') {
      callback = arguments[1];
      zip = arguments[0];
      country = 'US';
    }

    country = country.toUpperCase();
    // Only make unique requests
    if(!requests[country]) {
      requests[country] = {};
    }
    if(!requests[country][zip]) {
      requests[country][zip] = $.getJSON('https://zip.getziptastic.com/v2/' + country + '/' + zip);
    }

    // Bind to the finished request
    requests[country][zip].done(function(data) {
      if (typeof callback == 'function') {
        callback(data.country, data.state, data.state_short, data.city, zip);
      }
    });

    // Allow for binding to the deferred object
    return requests[country][zip];
  };

  $.fn.ziptastic = function( options ) {
    return this.each(function() {
      var ele = $(this);

      ele.on('keyup', function() {
        var zip = ele.val();

        // TODO Non-US zip codes?
        if(zipValid.us.test(zip)) {
          $.ziptastic(zip, function(country, state, state_short, city) {
            // Trigger the updated information
            ele.trigger('zipChange', [country, state, state_short, city, zip]);
          });
        }
      });
    });
  };
})( jQuery );


      $('#special').on('change', function(data) {
          var value = $('#special').val();
          console.log(value);
          var arr = value.split(", ");
          var city = arr[0];
          var state = arr[1];
          $("#user_address_city").val(city);
          $("#user_address_state").val(state);
      });

      // console.log("Hello");
      $('#registration_address_zip').ziptastic().on('zipChange', function(evt, country, state, state_short, city, zip) {
        console.log(city + ", " + state_short);
        if (city !== undefined && state_short !== undefined) {
          $("#special").val(city + ", " + state_short);
          $("#registration_address_state").val(state_short);
          $("#registration_address_city").val(city);
           
        }
        else {
          if ($('#registration_address_zip').val().length !== 0)  {
            $("#special").val("Zip code not found.");
          }
        }
      });

      function runner() {
          line_a = $("#registration_address_line_1").val();
          var home = line_a + ", " + $("#registration_address_city").val() + " " + $("#registration_address_state").val() + " " + $("#registration_address_zip").val();
          $("#registration_home").val(home);
          console.log(home);     
      }