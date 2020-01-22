var sphereVertexPositionBuffer;
var sphereVertexTextureCoordBuffer;
var sphereVertexIndexBuffer;

function InitSphere(gl, radius, latitudeBands, longitudeBands) {	
	var vertexPositionData = [];
	var textureCoordData = [];
	for (var latNumber=0; latNumber <= latitudeBands; latNumber++) {
		var theta = latNumber * 180 / latitudeBands;
		var sinTheta = Sin(theta);
		var cosTheta = Cos(theta);
		for (var longNumber=0; longNumber <= longitudeBands; longNumber++) {
		  var sphi = longNumber / longitudeBands;
			var phi = sphi * 360;
			var sinPhi = Sin(phi);
			var cosPhi = Cos(phi);

			var x = cosPhi * sinTheta;
			var y = cosTheta;
			var z = sinPhi * sinTheta;
			var u = 1 - (sphi);
			var v = 1 - (latNumber / latitudeBands);
			textureCoordData.push(u);
			textureCoordData.push(v);
			vertexPositionData.push(radius * x);
			vertexPositionData.push(radius * y);
			vertexPositionData.push(radius * z);
		}
	}
	var indexData = [];
	for (var latNumber=0; latNumber < latitudeBands; latNumber++) {
		for (var longNumber=0; longNumber < longitudeBands; longNumber++) {
			var first = (latNumber * (longitudeBands + 1)) + longNumber;
			var second = first + longitudeBands + 1;
			indexData.push(first);
			indexData.push(second);
			indexData.push(first + 1);

			indexData.push(second);
			indexData.push(second + 1);
			indexData.push(first + 1);
		}
	}

	sphereVertexTextureCoordBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, sphereVertexTextureCoordBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(textureCoordData), gl.STATIC_DRAW);
	sphereVertexTextureCoordBuffer.itemSize = 2;
	sphereVertexTextureCoordBuffer.numItems = textureCoordData.length / 2;

	sphereVertexPositionBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, sphereVertexPositionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertexPositionData), gl.STATIC_DRAW);
	sphereVertexPositionBuffer.itemSize = 3;
	sphereVertexPositionBuffer.numItems = vertexPositionData.length / 3;

	sphereVertexIndexBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereVertexIndexBuffer);
	gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(indexData), gl.STATIC_DRAW);
	sphereVertexIndexBuffer.itemSize = 1;
	sphereVertexIndexBuffer.numItems = indexData.length;
	
	return { spherePosBuf: sphereVertexPositionBuffer, 
	         sphereTexBuf: sphereVertexTextureCoordBuffer,
					 sphereIndexBuf: sphereVertexIndexBuffer };
}

var DrawSphere = function(gl, shader, pos, uv, texture, movematrix, sphereObject) {
  gl.uniformMatrix4fv(gl.getUniformLocation(shader, "Mmatrix"), false, movematrix);
	DrawTexture(gl, texture);
	gl.bindBuffer(gl.ARRAY_BUFFER, sphereObject.spherePosBuf);
	gl.vertexAttribPointer(pos, sphereObject.spherePosBuf.itemSize, gl.FLOAT, false, 0, 0);
	gl.bindBuffer(gl.ARRAY_BUFFER, sphereVertexTextureCoordBuffer);
	gl.vertexAttribPointer(uv, 2, gl.FLOAT, false, 0, 0);
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereObject.sphereIndexBuf);
	gl.drawElements(gl.TRIANGLES, sphereObject.sphereIndexBuf.numItems, gl.UNSIGNED_SHORT, 0);
}