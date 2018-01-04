// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
var zenscroll = require('./zenscroll-min.js');
function navListeners() {
  var navMenuButton = document.getElementById('nav-menu-button').addEventListener('click', toggleNav);
  var list = [
    "who-are-we",
    "how-it-works",
    "where-is-it",
    "testimonials",
    "contact"
  ]
  list.forEach(function (item) {
    var link = item + "-link"
    document.getElementById(link).addEventListener('click', function () {
      closeNav()
      var destination = document.getElementById(item);
      zenscroll.to(destination)
    });
  })
}

function toggleNav () {
  var menu = document.getElementById('nav-menu')
  if (menu.className.indexOf("dn") !== -1) {
    menu.className = menu.className.replace("dn", "")
  } else {
    menu.className += " dn"
  }
}

function openNav () {
  menu.className = menu.className.replace("dn", "");
}

function closeNav () {
  document.getElementById('nav-menu').className += " dn";
}

function timerListeners(day, month, year, id) {
  var timer = setInterval(function () {
    var eventDate = new Date(year, month - 1, day, 20).getTime();
    var today = new Date().getTime();
    var eventSeconds = Math.round(eventDate / 1000);
    var todaySeconds = Math.round(today / 1000);
    if (eventSeconds - todaySeconds < 0) {
      clearInterval(timer);
    } else {
      // seconds
      var secondsOut = eventSeconds - todaySeconds;
      var roundedSeconds = secondsOut % 60;
      var secondContainer = document.getElementById('seconds' + id);
      var secondTextContainer = document.getElementById('seconds-text' + id);
      secondContainer.innerHTML = zeroPad(roundedSeconds);

      // minutes
      var eventMinutes = eventSeconds / 60;
      var todayMinutes = todaySeconds / 60;
      var minutesOut = eventMinutes - todayMinutes;
      var roundedMinutes = Math.floor(minutesOut % 60);
      var minuteContainer = document.getElementById('minutes' + id);
      var minuteTextContainer = document.getElementById('minutes-text' + id);
      minuteContainer.innerHTML = zeroPad(roundedMinutes);
      if (roundedDays === 1) {
        minuteTextContainer.innerHTML = "minute";
      }
      // hours
      var eventHours = eventMinutes / 60;
      var todayHours = todayMinutes / 60;
      var hoursOut = eventHours - todayHours;
      var roundedHours = Math.floor(hoursOut % 24);
      var hourContainer = document.getElementById('hours' + id);
      var hourTextContainer = document.getElementById('hours-text' + id);
      hourContainer.innerHTML = zeroPad(roundedHours);
      if (roundedHours === 1) {
        hourTextContainer.innerHTML = "hour";
      }
      // days
      var eventDays = eventHours / 24;
      var todayDays = todayHours / 24;
      var daysOut = (eventDays - todayDays);
      var roundedDays = Math.floor(daysOut % 365);
      var dayContainer = document.getElementById('days' + id);
      var dayTextContainer = document.getElementById('days-text' + id);
      dayContainer.innerHTML = zeroPad(roundedDays);
      if (roundedDays === 1) {
        dayTextContainer.innerHTML = "day";
      }
    }
  }, 1000)
}

function zeroPad(time) {
  var timeString = time.toString();
  var padded = "0" + timeString;
  var sliced = padded.slice(-2);
  return sliced;
}

function fadeIn() {
  $(document).ready(function() {

    /* Every time the window is scrolled ... */
    $(window).scroll( function(){

        /* Check the location of each desired element */
        $('.hideme').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object + 200){

                $(this).animate({'opacity':'1'}, 1500);

            }

        });
        $('.hidemenext').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object + 500){

                $(this).animate({'opacity':'1'}, 2000);

            }

        });
        $('.hidehowitworks1').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object + 1200){

                $(this).animate({'opacity':'1'}, 1000);

            }

        });
        $('.hidehowitworks2').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object + 1200){

                $(this).animate({'opacity':'1'}, 2000);

            }

        });
        $('.hidehowitworks3').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object + 1200){

                $(this).animate({'opacity':'1'}, 3000);

            }

        });

    });

});
}

export var App = {
  timerListeners: timerListeners,
  navListeners: navListeners,
  fadeIn: fadeIn
}
