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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require ./lib/moment
//= require ./lib/flowplayer
//= require ./lib/asf.min
//= require_tree ./lib
//= require_tree .


(function () {
  var timer;

  document.onmousemove = function () {
    $('body').addClass('mouse-moving');

    clearTimeout(timer);
    timer = setTimeout(function () {
      $('body').removeClass('mouse-moving');
    }, 2000);
  };

})();

$(document).ready(function () {
    $("img.lazy").lazyload({
      effect: 'fadeIn'
    });
});

$(function () {
  $('#like_form').submit(function (e) {
    e.preventDefault();

    var submit_button = $(this).find('input[type=submit]');
    var action = $(this).attr('action');

    submit_button.hide();

    $.ajax({
      type: 'POST',
      url: action,
      success: function () {
        $('#like_count').html(($('#like_count').html() * 1) + 1);
      }
    });
  });
});

$(function() {
   if (typeof $.fn.flowplayer == 'function') {
      $("video").parent(".flowplayer").flowplayer({
         cuepoints: [-0.1]
      }).bind("cuepoint", function(e, api, cuepoint) {
        $('.flowplayer .overlay').show();
      });
   }
});



Turbolinks.enableProgressBar();
