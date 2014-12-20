 $(function() {
    $( "#dialog" ).dialog({
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 10
      },
      hide: {
        effect: "explode",
        duration: 10
      }
    });
    if($("#error_text").text()!="") {
      $( "#dialog" ).dialog( "open" );
    }
});