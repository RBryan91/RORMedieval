document.addEventListener('DOMContentLoaded', function() {


var forceInputBis = document.getElementById('character_forceBis');
var pvInputBis = document.getElementById('character_pvBis');
var remainingPointsElementBis = document.getElementById('remaining_pointsBis');
var resetButtonBis = document.getElementById('reset_buttonBis');

var initial_forcePoints = parseInt(forceInputBis.value) || 0;
var initial_pvPoints = parseInt(pvInputBis.value) || 0;
var totalPointsBis = initial_forcePoints + initial_pvPoints + 10;

function updateRemainingPointsBis() {
  var forcePointsBis = parseInt(forceInputBis.value) || 0;
  var pvPointsBis = parseInt(pvInputBis.value) || 0;
  var remainingPointsBis = totalPointsBis - forcePointsBis - pvPointsBis;
  remainingPointsElementBis.textContent = 'Remaining Points: ' + remainingPointsBis;
  forceInputBis.disabled = remainingPointsBis === 0;
  pvInputBis.disabled = remainingPointsBis === 0;
}

function resetValuesBis() {
  forceInputBis.value = initial_forcePoints;
  pvInputBis.value = initial_pvPoints;
  updateRemainingPointsBis();
}

forceInputBis.addEventListener('input', updateRemainingPointsBis);
pvInputBis.addEventListener('input', updateRemainingPointsBis);
resetButtonBis.addEventListener('click', resetValuesBis);

var formBis = document.querySelector('#edit_form'); // Adjust the selector based on your actual form
formBis.addEventListener('submit', function() {
  // Enable the inputs before form submission
  forceInputBis.disabled = false;
  pvInputBis.disabled = false;
});

// Initial update
updateRemainingPointsBis();


});