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

	  $(document).ready(function(){
			$("#tasks_accordion #comments_list").toggle();
		  	$("#tasks_accordion #toggle_comments").click(function(){
		    $("#tasks_accordion #comments_list").toggle(1000);
		  });
	  });
});