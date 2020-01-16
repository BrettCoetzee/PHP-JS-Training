var loadLogin = function() {
  setupDatabase();
  $.post("databasing.php", { command: "user",  data: "" }, function(data) {
    document.getElementById("usernameLoginInput").value = data;
  });
}

var login = function() {
  var username = document.getElementById("usernameLoginInput").value;
  var pwd = document.getElementById("passwordLoginInput").value;
  if (isInvalid(username)) {
    feedback("Warning: please enter a valid username", true); return;
  }
  if (isInvalid(pwd)) {
    feedback("Warning: please enter a valid password", true); return;
  }
  var obj = { "Username": username, "Password": pwd };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", { command: "login",  data: objStr }, function(data) {
     feedback(data, true);
     if (data.includes("Success")) {
       getUsername();
       window.location.href = "index.html";
     }
  });
  if (document.getElementById("rememberLoginInput").checked) {
    $.post("databasing.php", { command: "cookie",  data: username }, function(data) { });
  }
}

var loadHome = function() {
  setupDatabase();
  getInfo();
  loadAllPosts(loadTable);
  $.post("databasing.php", { command: "user",  data: "" }, function(data) {
    if (isInvalid(data)) {
      window.location.href = "login.html";
    }
    else {
      document.getElementById("mainContainer").style.display = "block";
    }
  });
}

var loadAllPosts = function(loadTable) {
  $.post("databasing.php", { command: "load",  data: "" }, function(data) {
     feedback(data);
     loadTable(data);
  });
}

var logout = function() {
   $.post("databasing.php", { command: "logout",  data: "" }, function(data) {
     window.location.href = "login.html";
  });
}

var loadTable = function(value) {
  var cl = document.getElementById("chirpList");
  var clRows = cl.getElementsByTagName('li');
  while(cl.firstChild){
    cl.removeChild( cl.firstChild );
  }
  var rowArray = JSON.parse(value.replace(/[\r\n]/g, "<br />"));
  var rowInt = 0;
  rowArray.sort(function(a,b) { 
    return new Date(b.PostTimeStamp) - new Date(a.PostTimeStamp); 
  });
  rowArray.forEach(function(obj) {
    var li = document.createElement("li");
    var newdiv = document.createElement('div');
    newdiv.innerHTML = '<div class="panel panel-info"><h1 style="font-size:30px;background-color:#5bc0de;border:1.5px solid black;" class="panel-title"><img src="images/chirp.png" style="width:60px"> ' + 
                       obj["UserId"] + " @ " + obj["PostTimeStamp"] + '</h1><div class="panel-body">' + obj["PostText"].replace('\n\r','') + '</div></div>';
    li.appendChild(newdiv);
    cl.appendChild(li);
  });
}

var chirp = function() {
  var chirpText = document.getElementById("chirpInput").value;
    if (!isInvalid(chirpText)) {
    $.post("databasing.php", {command: "chirp",  data: chirpText}, function(data) {
       feedback(data);
       loadAllPosts(loadTable);
       document.getElementById("chirpInput").value = "";
    });
  }
  else {
    feedback("Warning: Please enter a valid chirp (no funny characters, and cannot be blank)", true);
  }
}

var register = function() {
  var obj = checks("Register");
  if (document.getElementById("emailCodeRegisterInput").value != document.getElementById("emailCode").value) {
    feedback("Warning: email code validation failed", true); 
    return null;
  }
  if (obj != null) {
    var objStr = JSON.stringify(obj);
    $.post("databasing.php", {command: "register",  data: objStr }, function(data) {
       feedback(data, true);
       if (data.includes("Success")) {
         window.location.href = "index.html";
       }
    });
  }
}

var gotoEditInformation = function() {
  window.location.href = "config.html";
}

var cancelEditInformation = function() {
  window.location.href = "index.html";
}

var getUsername = function() {
  $.post("databasing.php", {command: "user",  data: "" }, function(data) {
    document.getElementById("usernameText").innerHTML = data;
  });
}

var getInfo = function() {
  getUsername();
  $.post("databasing.php", {command: "loaduser",  data: "" }, function(data) {
    var obj = JSON.parse(data);
    document.getElementById("infoText").innerHTML = obj.Name + " " + obj.Surname;
  });
}

var loadInformation = function() {
  setupDatabase();
  document.getElementById("emailCode").value = Math.floor((Math.random() * 1000) + 1);
  getUsername();
  $.post("databasing.php", {command: "loaduser",  data: "" }, function(data) {
    var obj = JSON.parse(data);
    document.getElementById("nameEditInput").value = obj.Name;
    document.getElementById("surnameEditInput").value = obj.Surname;
    document.getElementById("emailEditInput").value = obj.EmailAddress;
  });
}

var editInformation = function() {
  var obj = checks("Edit");
  if (obj != null) {
    var objStr = JSON.stringify(obj);
    $.post("databasing.php", {command: "save",  data: objStr }, function(data) {
       feedback(data);
       if (data.includes("Success")) {
         window.location.href = "index.html";
       }
    });
  }
}

var setupDatabase = function() {
  $.post("databasing.php", {command: "setup",  data: "" }, function(data) {
     feedback(data);
  });
}

// Ensure provided user data is valid, and provide feedback if not
var checks = function(data) {
  // TODO highlight field at fault
  var name = document.getElementById("name" + data + "Input").value;
  if (isInvalid(name)) {
    feedback("Warning: please enter a valid name", true); return null;
  }
  var surname = document.getElementById("surname" + data + "Input").value;
  if (isInvalid(surname)) {
    feedback("Warning: please enter a valid surname", true); return null;
  }
  var email = document.getElementById("email" + data + "Input").value;
  if (!checkEmailAddress(email)) {
    feedback("Warning: please provide a valid email address in the format some.thing@address.com", true); return null;
  }
  var u = document.getElementById("usernameText").textContent;
  var username = data == "Edit" ? u : document.getElementById("username" + data + "Input").value;
  if (isInvalid(username)) {
    feedback("Warning: please enter a valid username", true); return null;
  }
  var pwd = document.getElementById("password" + data + "Input").value;
  if (!checkPasswordComplexity(pwd)) {
    feedback("Warning: please enter a valid password at least 8 characters long (include a lower case, uppercase, special !@#$%^&*, and number character)", true); return null;
  }
  var confirmPwd = document.getElementById("confirmPassword" + data + "Input").value;
  if (pwd != confirmPwd) {
    feedback("Warning: passwords do not match", true); return null;
  }
  return { "Name": name, "Surname": surname, "Email": email, "Username": username, "Password": pwd };
}

// Utilities
// ====================================================================================
// Feedback handler
var feedbackEnabled = false;
var feedback = function(data, override = false) {
  if (override || feedbackEnabled) {
    var e = document.getElementById('feedbackText');
    e.innerHTML = data;
    if (data.includes("Error")) {
      e.style.color = "red";
    }
    else if (data.includes("Success")) {
      e.style.color = "lightgreen";
    }
    else if (data.includes("Warning")) {
      e.style.color = "orange";
    }  
    else {
      e.style.color = "black";
    }
  }
}

// String checking
function isInvalid(str){
  return (str.match(/[\-=\[\]{};':"\\|,<>\/]/)) || str.str === null || str.match(/^ *$/) !== null;
}
function checkPasswordComplexity(data) {
  if (data.length < 8) {
    return false;
  }
  if (isInvalid(data)) {
    return false;
  }
  if (!data.match("[A-Z]+")) {
    return false;
  }
  if (!data.match("[a-z]+")) {
    return false;
  }
  if (!data.match("[!@#$%^&*]+")) {
    return false;
  }
  if (!data.match("[0-9]+")) {
    return false;
  }
  return true;
}
var checkEmailAddress = function(emailStr) {
  if (!emailStr.match(/^[A-Za-z0-9\.]+@[A-Za-z0-9]+\.[A-Za-z0-9\.]+$/i)) {
    feedback("Warning: Please provide a valid email address in the format some.thing@address.com");
    return false;
  }
  return true;
}

// Timer
var t0 = 0;
var startTimer = function() {
  t0 = performance.now();
}

var elapsedTime = function(){
  document.getElementById('feedbackTimer').innerHTML = "Elapsed: " + (performance.now() - t0).toPrecision(3) + "ms";
}
// ====================================================================================

// SMTP
// ====================================================================================
var emailPost = function() {
  var obj = { "EmailAddress": document.getElementById("emailText").value, "Message": document.getElementById("chirpInput").value };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", {command: "email",  data: objStr }, function(data) {
     alert(data);
  });
}
var emailCode = function() {
  var randomNumber = Math.floor((Math.random() * 1000) + 1);
  document.getElementById("emailCode").value = randomNumber;
  var obj = { "EmailAddress": document.getElementById("emailRegisterInput").value, 
              "Message": "Use the following number as the Email Code: " + randomNumber};
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", {command: "email",  data: objStr }, function(data) {
     alert(data);
  });
}
// ====================================================================================