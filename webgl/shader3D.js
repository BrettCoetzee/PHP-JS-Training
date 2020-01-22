var Reinit3DShader = function(gl, shader, canvas, view, projection)
{
  gl.viewport(0, 0, canvas.width, canvas.height);
	gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
	gl.uniformMatrix4fv(gl.getUniformLocation(shader, "Vmatrix"), false, view);
	gl.uniformMatrix4fv(gl.getUniformLocation(shader, "Pmatrix"), false, projection);
}

var Get3DShader = function(gl, source, type)
{
	var shader = gl.createShader(type);
	gl.shaderSource(shader, source);
	gl.compileShader(shader);
	var compiled = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
  if (!compiled)
	{
    alert(gl.getShaderInfoLog(shader));
	}
	return shader;
};

var Set3DShaderColor = function (gl, shader, r, g, b, i)
{
	gl.uniform1f(gl.getUniformLocation(shader, "uRed"), r);
	gl.uniform1f(gl.getUniformLocation(shader, "uGreen"), g);
	gl.uniform1f(gl.getUniformLocation(shader, "uBlue"), b);
	gl.uniform1f(gl.getUniformLocation(shader, "uIntensity"), i);
}

var Set3DPerspective = function(angle, a, zMin, zMax) 
{
  var tan = Math.tan(DegToRad(0.5*angle));
  var A = -(zMax + zMin) / (zMax - zMin);
  var B = (-2 * zMax * zMin) / (zMax - zMin);
  
  return [0.5 / tan, 0,              0,  0,
          0,         0.5 * a / tan,  0,  0,
          0,         0,              A, -1,
          0,         0,              B,  0 ];
}

var Rotate3DX = function(m, angle) 
{
	var c = Math.cos(angle);
	var s = Math.sin(angle);
	m[1] = c*m[1] - s*m[2];
	m[5] = c*m[5] - s*m[6];
	m[9] = c*m[9] - s*m[10];
	m[2] = c*m[2] + s*m[1];
	m[6] = c*m[6] + s*m[5];
	m[10] = c*m[10] + s*m[9];
}
  
var Rotate3DY = function(m, angle) 
{
  var c = Math.cos(angle);
	var s = Math.sin(angle);
	m[0] = c*m[0] + s*m[2];
	m[4] = c*m[4] + s*m[6];
	m[8] = c*m[8] + s*m[10];
	m[2] = c*m[2] - s*m[0];
	m[6] = c*m[6] - s*m[4];
	m[10] = c*m[10] - s*m[8];
}

var Rotate3DZ = function(m, angle) 
{
  var c = Math.cos(angle);
	var s = Math.sin(angle);
	m[0] = c*m[0] - s*m[1];
	m[4] = c*m[4] - s*m[5];
	m[8] = c*m[8] - s*m[9];
	m[1]= c*m[1] + s*m[0];
	m[5]= c*m[5] + s*m[4];
	m[9]= c*m[9] + s*m[8];
}

var Get3DX = function(m) { return m[12]; }
var Get3DY = function(m) { return m[13]; }
var Get3DZ = function(m) { return m[14]; }

var Translate3DX = function(m, t) { m[12]+=t; }
var Translate3DY = function(m, t) { m[13]+=t; }
var Translate3DZ = function(m, t) { m[14]+=t; }

var Reset3DX = function(m, t) { m[12]=t; }
var Reset3DY = function(m, t) { m[13]=t; }
var Reset3DZ = function(m, t) { m[14]=t; }

var Limit3DX = function(m, tmin, tmax)
{
  m[12] = m[12] > tmax ? tmax : m[12];
	m[12] = m[12] < tmin ? tmin : m[12];
}
var Limit3DY = function(m, tmin, tmax)
{
  m[13] = m[13] > tmax ? tmax : m[13];
	m[13] = m[13] < tmin ? tmin : m[13];
}
var Limit3DZ = function(m, tmin, tmax)
{
  m[14] = m[14] > tmax ? tmax : m[14];
	m[14] = m[14] < tmin ? tmin : m[14];
}