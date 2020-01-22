var TEX;

var InitTextures3D = function(imageURL, gl){
  TEX = GetTexture(imageURL, gl);
}

var GetTexture = function(imageURL, gl) {
	var image = new Image();
	image.src = imageURL;
	image.webglTexture = false;
	return LoadTexture(image, gl);
}

var LoadTexture = function(image, gl) {
  image.onload = function(e) {
		var texture = gl.createTexture();  
		gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
		gl.bindTexture(gl.TEXTURE_2D, texture);
		gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST_MIPMAP_LINEAR);

		// ==== ENABLE NON POWER-OF-TWO IMAGES ====
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE); // Prevents s-coordinate wrapping (repeating).
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE); // Prevents t-coordinate wrapping (repeating).
		// ==== END OF ENABLE NON POWER-OF-TWO IMAGES ====

		gl.generateMipmap(gl.TEXTURE_2D);
		gl.bindTexture(gl.TEXTURE_2D, null);
		image.webglTexture = texture;
	};
  return image;
}
 
var DrawTexture = function(gl, texture) {
  if (texture.webglTexture) {
		gl.activeTexture(gl.TEXTURE0);
		gl.bindTexture(gl.TEXTURE_2D, texture.webglTexture);
	}
}