var loginMain = function() {
  InitMath();
  var inputobj1 = { "CanvasName": "canvas1" };
  var outputobj1 = Init3D(inputobj1);
  
	
	// ==== CYCLIC PROCESSING ====
  var myVar = setInterval(mainLoop, 80);
  function mainLoop(){
    Manage3D(outputobj1);
  }
}