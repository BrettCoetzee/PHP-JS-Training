var cosArray = new Array();
var sinArray = new Array();
var tanArray = new Array();
var arctanArray = new Array();
var CONVDEGTORAD;

var InitMath = function()
{
  CONVDEGTORAD = Math.PI / 180;
  for (var i = -180; i <= 180; i++) { sinArray[i+180] = Math.sin(i * CONVDEGTORAD); }
	for (var i = -180; i <= 180; i++) { cosArray[i+180] = Math.cos(i * CONVDEGTORAD); }
  for (var i = -180; i <= 180; i++) { tanArray[i+180] = Math.tan(i * CONVDEGTORAD); }
	for (var i = 0; i < 400; i++) { arctanArray[i] = CONVDEGTORAD * Math.atan(i / 20); }
}

var NormAngle = function(angleInDeg)
{
	var timeout = 0;
	while(timeout < 10 && (angleInDeg > 180 || angleInDeg < -180))
	{
		angleInDeg = angleInDeg > 180 ? angleInDeg - 360 : angleInDeg + 360;
		timeout++;
	}
	return angleInDeg;
}

var Round = function(valueIn)  { return (valueIn < 0 ? - Math.round(Math.abs(valueIn)) : Math.round(valueIn)); }
var Sin = function(angleInDeg) { return sinArray[Round(NormAngle(angleInDeg)) + 180]; }
var Cos = function(angleInDeg) { return cosArray[Round(NormAngle(angleInDeg)) + 180]; }
var Tan = function(angleInDeg) { return tanArray[Round(NormAngle(angleInDeg)) + 180]; }
var Arctan = function(valueIn) { return arctanArray[Round(valueIn * 20)]; }

var DegToRad = function(angle) { return angle * CONVDEGTORAD; }

var GetI4 = function() 
{
	return [1,0,0,0,
					0,1,0,0,
					0,0,1,0,
					0,0,0,1];
}

var SetI4 = function(m)
{
	m[0]=1, m[1]=0, m[2]=0, m[3]=0,
	m[4]=0, m[5]=1, m[6]=0, m[7]=0,
	m[8]=0, m[9]=0, m[10]=1,m[11]=0,
	m[12]=0,m[13]=0,m[14]=0,m[15]=1;
}

function CrossProd(a, b)
{
  return [a[1]*b[2] - a[2]*b[1],
          a[2]*b[0] - a[0]*b[2],
          a[0]*b[1] - a[1]*b[0]];
}

function SubtractVectors(a, b)
{
  return [a[0] - b[0], a[1] - b[1], a[2] - b[2]];
}

function Normalize(v)
{
  var length = Math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
  
  // make sure we don't divide by 0.
  if (length > 0.00001)
  {
    return [v[0] / length, v[1] / length, v[2] / length];
  } 
  else 
  {
    return [0, 0, 0];
  }
}

function MakeLookAt(cameraPosition, target, up) 
{
  var zAxis = normalize(SubtractVectors(cameraPosition, target));
  var xAxis = CrossProd(up, zAxis);
  var yAxis = CrossProd(zAxis, xAxis);
 
  return [xAxis[0], xAxis[1], xAxis[2], 0,
          yAxis[0], yAxis[1], yAxis[2], 0,
          zAxis[0], zAxis[1], zAxis[2], 0,
          cameraPosition[0],
          cameraPosition[1],
          cameraPosition[2],
					1];
}

function MakeTranslation(tx, ty, tz)
{
  return [1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          tx,ty,tz,1];
}

function MakeInverse(m)
{
  var m00 = m[0 * 4 + 0];
  var m01 = m[0 * 4 + 1];
  var m02 = m[0 * 4 + 2];
  var m03 = m[0 * 4 + 3];
  var m10 = m[1 * 4 + 0];
  var m11 = m[1 * 4 + 1];
  var m12 = m[1 * 4 + 2];
  var m13 = m[1 * 4 + 3];
  var m20 = m[2 * 4 + 0];
  var m21 = m[2 * 4 + 1];
  var m22 = m[2 * 4 + 2];
  var m23 = m[2 * 4 + 3];
  var m30 = m[3 * 4 + 0];
  var m31 = m[3 * 4 + 1];
  var m32 = m[3 * 4 + 2];
  var m33 = m[3 * 4 + 3];
  var tmp_0  = m22 * m33;
  var tmp_1  = m32 * m23;
  var tmp_2  = m12 * m33;
  var tmp_3  = m32 * m13;
  var tmp_4  = m12 * m23;
  var tmp_5  = m22 * m13;
  var tmp_6  = m02 * m33;
  var tmp_7  = m32 * m03;
  var tmp_8  = m02 * m23;
  var tmp_9  = m22 * m03;
  var tmp_10 = m02 * m13;
  var tmp_11 = m12 * m03;
  var tmp_12 = m20 * m31;
  var tmp_13 = m30 * m21;
  var tmp_14 = m10 * m31;
  var tmp_15 = m30 * m11;
  var tmp_16 = m10 * m21;
  var tmp_17 = m20 * m11;
  var tmp_18 = m00 * m31;
  var tmp_19 = m30 * m01;
  var tmp_20 = m00 * m21;
  var tmp_21 = m20 * m01;
  var tmp_22 = m00 * m11;
  var tmp_23 = m10 * m01;

  var t0 = (tmp_0 * m11 + tmp_3 * m21 + tmp_4 * m31) -
      (tmp_1 * m11 + tmp_2 * m21 + tmp_5 * m31);
  var t1 = (tmp_1 * m01 + tmp_6 * m21 + tmp_9 * m31) -
      (tmp_0 * m01 + tmp_7 * m21 + tmp_8 * m31);
  var t2 = (tmp_2 * m01 + tmp_7 * m11 + tmp_10 * m31) -
      (tmp_3 * m01 + tmp_6 * m11 + tmp_11 * m31);
  var t3 = (tmp_5 * m01 + tmp_8 * m11 + tmp_11 * m21) -
      (tmp_4 * m01 + tmp_9 * m11 + tmp_10 * m21);

  var d = 1.0 / (m00 * t0 + m10 * t1 + m20 * t2 + m30 * t3);

  return [
    d * t0,
    d * t1,
    d * t2,
    d * t3,
    d * ((tmp_1 * m10 + tmp_2 * m20 + tmp_5 * m30) -
          (tmp_0 * m10 + tmp_3 * m20 + tmp_4 * m30)),
    d * ((tmp_0 * m00 + tmp_7 * m20 + tmp_8 * m30) -
          (tmp_1 * m00 + tmp_6 * m20 + tmp_9 * m30)),
    d * ((tmp_3 * m00 + tmp_6 * m10 + tmp_11 * m30) -
          (tmp_2 * m00 + tmp_7 * m10 + tmp_10 * m30)),
    d * ((tmp_4 * m00 + tmp_9 * m10 + tmp_10 * m20) -
          (tmp_5 * m00 + tmp_8 * m10 + tmp_11 * m20)),
    d * ((tmp_12 * m13 + tmp_15 * m23 + tmp_16 * m33) -
          (tmp_13 * m13 + tmp_14 * m23 + tmp_17 * m33)),
    d * ((tmp_13 * m03 + tmp_18 * m23 + tmp_21 * m33) -
          (tmp_12 * m03 + tmp_19 * m23 + tmp_20 * m33)),
    d * ((tmp_14 * m03 + tmp_19 * m13 + tmp_22 * m33) -
          (tmp_15 * m03 + tmp_18 * m13 + tmp_23 * m33)),
    d * ((tmp_17 * m03 + tmp_20 * m13 + tmp_23 * m23) -
          (tmp_16 * m03 + tmp_21 * m13 + tmp_22 * m23)),
    d * ((tmp_14 * m22 + tmp_17 * m32 + tmp_13 * m12) -
          (tmp_16 * m32 + tmp_12 * m12 + tmp_15 * m22)),
    d * ((tmp_20 * m32 + tmp_12 * m02 + tmp_19 * m22) -
          (tmp_18 * m22 + tmp_21 * m32 + tmp_13 * m02)),
    d * ((tmp_18 * m12 + tmp_23 * m32 + tmp_15 * m02) -
          (tmp_22 * m32 + tmp_14 * m02 + tmp_19 * m12)),
    d * ((tmp_22 * m22 + tmp_16 * m02 + tmp_21 * m12) -
          (tmp_20 * m12 + tmp_23 * m22 + tmp_17 * m02))
  ];
}

function MatrixMultiply(a, b) 
{
  var a00 = a[0*4+0];
  var a01 = a[0*4+1];
  var a02 = a[0*4+2];
  var a03 = a[0*4+3];
  var a10 = a[1*4+0];
  var a11 = a[1*4+1];
  var a12 = a[1*4+2];
  var a13 = a[1*4+3];
  var a20 = a[2*4+0];
  var a21 = a[2*4+1];
  var a22 = a[2*4+2];
  var a23 = a[2*4+3];
  var a30 = a[3*4+0];
  var a31 = a[3*4+1];
  var a32 = a[3*4+2];
  var a33 = a[3*4+3];
  var b00 = b[0*4+0];
  var b01 = b[0*4+1];
  var b02 = b[0*4+2];
  var b03 = b[0*4+3];
  var b10 = b[1*4+0];
  var b11 = b[1*4+1];
  var b12 = b[1*4+2];
  var b13 = b[1*4+3];
  var b20 = b[2*4+0];
  var b21 = b[2*4+1];
  var b22 = b[2*4+2];
  var b23 = b[2*4+3];
  var b30 = b[3*4+0];
  var b31 = b[3*4+1];
  var b32 = b[3*4+2];
  var b33 = b[3*4+3];
  return [a00 * b00 + a01 * b10 + a02 * b20 + a03 * b30,
          a00 * b01 + a01 * b11 + a02 * b21 + a03 * b31,
          a00 * b02 + a01 * b12 + a02 * b22 + a03 * b32,
          a00 * b03 + a01 * b13 + a02 * b23 + a03 * b33,
          a10 * b00 + a11 * b10 + a12 * b20 + a13 * b30,
          a10 * b01 + a11 * b11 + a12 * b21 + a13 * b31,
          a10 * b02 + a11 * b12 + a12 * b22 + a13 * b32,
          a10 * b03 + a11 * b13 + a12 * b23 + a13 * b33,
          a20 * b00 + a21 * b10 + a22 * b20 + a23 * b30,
          a20 * b01 + a21 * b11 + a22 * b21 + a23 * b31,
          a20 * b02 + a21 * b12 + a22 * b22 + a23 * b32,
          a20 * b03 + a21 * b13 + a22 * b23 + a23 * b33,
          a30 * b00 + a31 * b10 + a32 * b20 + a33 * b30,
          a30 * b01 + a31 * b11 + a32 * b21 + a33 * b31,
          a30 * b02 + a31 * b12 + a32 * b22 + a33 * b32,
          a30 * b03 + a31 * b13 + a32 * b23 + a33 * b33];
}

function Rotate3Dx(angleInRadians)
{
  var c = Math.cos(angleInRadians);
  var s = Math.sin(angleInRadians);

  return [1, 0, 0, 0,
					0, c, s, 0,
					0, -s, c, 0,
					0, 0, 0, 1];
};

function Rotate3Dy(angleInRadians)
{
  var c = Math.cos(angleInRadians);
  var s = Math.sin(angleInRadians);

  return [c, 0, -s, 0,
					0, 1, 0, 0,
					s, 0, c, 0,
					0, 0, 0, 1];
};

function Rotate3Dz(angleInRadians)
{
  var c = Math.cos(angleInRadians);
  var s = Math.sin(angleInRadians);
  return [
     c, s, 0, 0,
    -s, c, 0, 0,
     0, 0, 1, 0,
     0, 0, 0, 1,
  ];
}