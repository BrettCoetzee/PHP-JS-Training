var iteration = 0;
var direction = true;

var Init3D = function(obj)
{  
  var size = 0.6;
	var canvas = document.getElementById(obj.CanvasName);
  canvas.width = size * window.innerWidth;
  canvas.height = size * window.innerHeight;
  canvas.style.width =  size * window.innerWidth + "px";
  canvas.style.width =  size * window.innerHeight + "px";
  //canvas.style.top = window.innerHeight / 2.0;
  //canvas.style.left = -115;
	var gl = canvas.getContext("experimental-webgl", {antialias: true});
  var shader = gl.createProgram();
  gl.attachShader(shader, Get3DShader(gl, document.getElementById("3DvertShader").text, gl.VERTEX_SHADER));
  gl.attachShader(shader, Get3DShader(gl, document.getElementById("3DfragShader").text, gl.FRAGMENT_SHADER)); 
  gl.linkProgram(shader);
  gl.useProgram(shader);
  var uv = gl.getAttribLocation(shader, "uv");
  var pos = gl.getAttribLocation(shader, "position");
  gl.enableVertexAttribArray(uv);
  gl.enableVertexAttribArray(pos);

  // ==== MATRIX INIT ====
  var projection = Set3DPerspective(40, canvas.width / canvas.height, 0.1, 100);
  var view = GetI4();
  

  // ==== 3D TEXTURES ====
  InitTextures3D("images/tex.png", gl);
  
  // ==== 3D DRAWING INITIALISATION ====
  gl.enable(gl.DEPTH_TEST);
  gl.depthFunc(gl.LEQUAL);
  gl.clearColor(0.0, 0.0, 0.0, 0.0);
  gl.clearDepth(1.0);

	// ==== 3D CONFIG ====	
	Set3DShaderColor(gl, shader, 1, 1, 1, 1);
  Translate3DZ(view, -70);
  
  var sphere = InitSphere(gl, 20, 100, 50);
  var sphereview = GetI4();
  sphereview = MatrixMultiply(sphereview, Rotate3Dy(1.57));
  
  return { "Canvas": canvas, "GL": gl, "Shader": shader, "Pos": pos, "UV": uv, "View": view, "Projection": projection,
           "Sphere": sphere, "SphereView": sphereview };
}

var Manage3D = function(obj)
{
	Reinit3DShader(obj.GL, obj.Shader, obj.Canvas, obj.View, obj.Projection);
  DrawSphere(obj.GL, obj.Shader, obj.Pos, obj.UV, TEX, obj.SphereView, obj.Sphere);
  if (direction == true) {
    iteration++;
    obj.SphereView = MatrixMultiply(obj.SphereView, Rotate3Dy(0.01));
  }
  else {
    iteration--;
    obj.SphereView = MatrixMultiply(obj.SphereView, Rotate3Dy(-0.01));
  }
  if (iteration > 20) {
    direction = false;
  }
  if (iteration < -20) {
    direction = true;
  }
  
	obj.GL.flush();
}