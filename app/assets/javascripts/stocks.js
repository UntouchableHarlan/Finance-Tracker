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
      onLoading: showSpinner(),
      success: function(responseText) {
        $("#stock-lookup").replaceWith(responseText);
        hideSpinner();
        stockSearch();
      },// end success
      error: function(responseText, status) {
        console.log(status);
        if (status === 'error') {
          $('#results').replaceWith("  ")
          $("#error-results").html("Stock was not found").show();
          hideSpinner();
          stockSearch();
        }
      } // end error
    }); //end ajax
  }); // end sumbit
}; // end stock search


var delete_stock = function(){
  $('#delete-stock').on('click', function(event){
    event.preventDefault();
    console.log('clicked');
    $.ajax({
      type: $(this).attr('data-method'),
      url: $(this).attr('href'),
      success: function(){
        $('#already-added').load();
      }// end success
    })// end ajax
  });//end on click
};

$(document).ready(function(){
  $("#error-results").hide();
  stockSearch();
  delete_stock();
});
