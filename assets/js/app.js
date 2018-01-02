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
function timerListeners(day, month, year, id) {
  var timer = setInterval(function () {
    var eventDate = new Date(year, month - 1, day, 13, 58).getTime();
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

export var App = {
  timerListeners: timerListeners
}
