$(function(){

    // Date picker for timesheet date setter
    $(function() {
      $(".datepicker").datepicker();
    });

    //Hide div with the following ids
		$("#language_other").hide();

    $('#language').click(function(){
      console.log($(this).val());
      if ($(this).val()=="other") {
      	$("#language_other").show("fast");
      } else {
        $("#language_other").hide("fast");
      }
    });
});
