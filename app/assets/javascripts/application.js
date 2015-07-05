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
//= require ./lib/moment
//= require ./lib/livestamp
//= require video

$(function () {
  $('.js-vote').submit(function (e) {
    e.preventDefault();

    var action = $(this).attr('action');
    var form_fields = $(this).serialize();

    $.ajax({
      type: 'POST',
      url: action,
      data: form_fields,
      success: function (response) {
        $.each(response, function (key, value) {
            $('.js-' + key).html(value);
        });
      }
    });

    $(this).find('button').attr('disabled', 'disabled');
  });
});
