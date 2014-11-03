// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require gritter
//= require_tree .


$.extend($.gritter.options, {
      class_name: 'gritter-light', // for light notifications (can be added directly to $.gritter.add too)
      position: 'bottom-right', // possibilities: bottom-left, bottom-right, top-left, top-right
      fade_in_speed: 100, // how fast notifications fade in (string or int)
      fade_out_speed: 100, // how fast the notices fade out
      time: 2500 // hang on the screen for...
    });
