document.addEventListener('DOMContentLoaded', function() {
  var totalPoints = 30;

  // Script for the first form
  var forceInput = document.getElementById('character_force');
  var pvInput = document.getElementById('character_pv');
  var remainingPointsElement = document.getElementById('remaining_points');
  var resetButton = document.getElementById('reset_button');

  function updateRemainingPoints() {
    console.log("should not be here");
    var forcePoints = parseInt(forceInput.value) || 0;
    var pvPoints = parseInt(pvInput.value) || 0;
    var remainingPoints = totalPoints - forcePoints - pvPoints;
    remainingPointsElement.textContent = 'Remaining Points: ' + remainingPoints;
    forceInput.disabled = remainingPoints === 0;
    pvInput.disabled = remainingPoints === 0;
  }

  function resetValues() {
    forceInput.value = 10;
    pvInput.value = 10;
    updateRemainingPoints();
  }

  forceInput.addEventListener('input', updateRemainingPoints);
  pvInput.addEventListener('input', updateRemainingPoints);
  resetButton.addEventListener('click', resetValues);

  var form = document.querySelector('#form'); // Adjust the selector based on your actual form
  form.addEventListener('submit', function() {
    // Enable the inputs before form submission
    forceInput.disabled = false;
    pvInput.disabled = false;
  });

  // Initial update
  updateRemainingPoints();

});