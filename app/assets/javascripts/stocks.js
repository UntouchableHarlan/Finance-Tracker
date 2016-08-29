 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/
var stockSearch = function(){
  $('#stock-lookup-form').submit(function(event, data, status){
    event.preventDefault();
    console.log('submitted');
    $.ajax({
      type: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function(responseText) {
        $("#stock-lookup").replaceWith(responseText);
      }// end success
    }); //end ajax
    stockSearch();
  }); // end sumbit
}; // end stock search


$(document).ready(function(){
  stockSearch();
});
