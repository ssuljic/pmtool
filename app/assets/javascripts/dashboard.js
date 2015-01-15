$(function() {
	  $( "#accordion" ).accordion({
	  	collapsible: true,
	  	active: false
	  });

	  $( "#accordion-assigned" ).accordion({
	  	collapsible: true,
	  	active: false
	  });

	  $( "#tasks_accordion" ).accordion({
	  	collapsible: true,
	  	active: false
	  });

	  $( "#datepicker" ).datepicker({
		  dateFormat: "yy-mm-dd"
		});
	  $( "#datepicker_end" ).datepicker({
		  dateFormat: "yy-mm-dd"
		});

	  $('.datetimepicker_from').datetimepicker({
  		format:'Y-m-d H:i',
  		lang:'en'
	  });

	   $('.datetimepicker_to').datetimepicker({
  		format:'Y-m-d H:i',
  		lang:'en'
	  });
});