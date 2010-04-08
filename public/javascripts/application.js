// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function toggle_new_location_fields(value){
  if (value == ""){
    $('new_location').show();
  }else{
    $('new_location').hide();
  }
}
