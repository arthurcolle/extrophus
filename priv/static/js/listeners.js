$(function() {
  /* event listener for ADD CARD button click */
	$("#addcard").on("click", function() {
		var name = $('#addcard').attr('data-name');
		var email = $('#addcard').attr('data-email');
		addStripeInformation({'name' : name, 'email' : email});
	});
});