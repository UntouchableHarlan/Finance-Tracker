// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require_tree .
var hideSpinner = function(){
  $('#spinner').hide();
};

var showSpinner = function(){
  $("#spinner").show();
}

var search_friends = function(){
  $('#friend-lookup-form').submit(function(event){
    event.preventDefault();
    $.ajax({
      type: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize(),
      onLoading: showSpinner(),
      success: function(responseText){
        $("#friend-lookup").replaceWith(responseText);
        hideSpinner();
        search_friends();
      }// end success
    })// end ajax
  }); // end submit
}

var delete_friend = function(){
  $('#delete-friend').on('click', function(event){
    event.preventDefault();
    console.log('clicked');
    $.ajax({
      type: $(this).attr('data-method'),
      url: $(this).attr('href'),
      success: function(){
        $('#friend-table').load();
      }// end success
    })// end ajax
  });//end on click
};

$(document).ready(function(){
  search_friends();
  delete_friend();
});
