var main = function() 
{
  var inputVal = document.getElementById('maxInput').value;  
  $.post("fibonacci.php", {max: inputVal}, function(data) { 
  document.getElementById('outputArray').innerHTML = data; 
  });
}