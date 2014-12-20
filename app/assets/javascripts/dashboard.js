$(function() {
	  $( "#accordion" ).accordion({
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
});