// Posts
var loadAllPosts = function(loadPosts) {
  $.post("databasing.php", { command: "load",  data: "" }, function(data) {
    feedback(data);
    loadPosts(data);
  });
}
var loadPosts = function(value) {
  var cl = document.getElementById("postList");
  while(cl.firstChild){
    cl.removeChild( cl.firstChild );
  }
  var rowArray = JSON.parse(value);
  rowArray.sort(function(a,b) { return new Date(b.PostTimeStamp) - new Date(a.PostTimeStamp); });
  var count = 0;
  rowArray.forEach(function(obj) {
    var li = document.createElement("li");
    var newdiv = document.createElement('div');
    var fn = "images/" + obj["UserId"] + ".png";
    if (!imageExists(fn)) {
      fn = "images/webcat.png";
    }
    var postText = obj["PostText"].replace(/&#10;/g, "");
    var hasText = false;
    var postArea = '<div class="panel-body" style="overflow-wrap: break-word;">' + obj["CommandText"];
    if (postText.match(/\S/)) {
       postArea += '<textarea id="post'+count+'" class="post-text" onclick="copyToClipboard(this)" style="color:#000000;">' + postText + '</textarea>';
       hasText = true;
    }
    postArea += '</div>';
    newdiv.innerHTML = '<div class="panel panel-info custom-panel" style="border:1.5px solid lightgrey;padding:3px;margin-bottom:10px;">' +
        '<button class="run-button" id="pcr'+obj["CommandInt"]+'" data-value="'+obj["CommandText"]+'" onclick="runCommand(this.id, true)">Run</button>' +
        '<img src="' + fn + '" style="height:29px;padding-left:5px;padding-right:5px;">' + obj["UserId"] + " @ " + obj["PostTimeStamp"] +
         postArea +
        '</div>';
    li.appendChild(newdiv);
    cl.appendChild(li);
    if (hasText) {
      const tx = document.getElementById('post' + count);
      tx.setAttribute('style', 'height:auto;');
      tx.setAttribute('style', 'height:' + (tx.scrollHeight + 20) + 'px;overflow-y:hidden;');
      count++;
    }
  });
}

function copyToClipboard(element) {
  element.select();
  element.setSelectionRange(0, 99999); /*For mobile devices*/
  document.execCommand("copy");
}

// Login
// ====================================================================================
var loadLogin = function() {
  loginMain();
  setupDatabase();
  $.post("databasing.php", { command: "user",  data: "" }, function(data) {
    document.getElementById("usernameLoginInput").value = data;
  });
}

var timeout = 0;
var login = function() {
  var time = elapsedTime();
  if (time < timeout) {
    feedback("Warning: Login blocked. Please wait another " + ((timeout - time)/1000) + "s", true); return;
  }
  var username = document.getElementById("usernameLoginInput").value;
  var pwd = document.getElementById("passwordLoginInput").value;
  if (isInvalid(username)) {
    feedback("Warning: enter a valid username", true); return;
  }
  if (isInvalid(pwd)) {
    feedback("Warning: enter a valid password", true); return;
  }
  var obj = { "Username": username, "Password": pwd };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", { command: "login",  data: objStr }, function(data) {
     feedback(data, true);
     if (data.includes("Success")) {
       getUsername();
       window.location.href = "index.html";
     }
     else {
       startTimer();
       timeout = 10000;
     }
  });
}
// ====================================================================================

// Home
// ====================================================================================
var loadHome = function() {
  // Security
  $.post("databasing.php", { command: "user",  data: "" }, function(username) {
    if (isInvalid(username)) {
      window.location.href = "login.html";
    }
    else {
      setupDatabase();
      getInfo();
      loadAllPosts(loadPosts);
      loadAllConfig(loadConfig);
      loadAllAutomations(loadAutomations);
      document.getElementById("mainContainer").style.display = "block";
      loadPP(username);
    }
  });
}

var logout = function() {
   $.post("databasing.php", { command: "logout",  data: "" }, function(data) {
     window.location.href = "login.html";
  });
}

var chirp = function() {
  var chirpText = document.getElementById("chirpInput").value;
    if (!isInvalid(chirpText)) {
    $.post("databasing.php", {command: "chirp",  data: chirpText}, function(data) {
       feedback(data, true);
       loadAllPosts(loadPosts);
       document.getElementById("chirpInput").value = "";
    });
  }
  else {
    feedback("Warning: enter a valid chirp (cannot be blank)", true);
  }
}

var gotoEditInformation = function() {
  window.location.href = "config.html";
}
// ====================================================================================

// Registration
// ====================================================================================
var register = function() {
  var name = document.getElementById("nameRegisterInput").value;
  if (isUnsafe(name)) {
    feedback("Warning: enter a valid name (no funny characters, not blank)", true); 
    return;
  }
  var surname = document.getElementById("surnameRegisterInput").value;
  if (isUnsafe(surname)) {
    feedback("Warning: enter a valid surname (no funny characters, not blank)", true); 
    return;
  }
  var email = document.getElementById("emailRegisterInput").value;
  if (!checkEmailAddress(email)) {
    feedback("Warning: provide a valid email address in the format some.thing@address.com", true); 
    return;
  }
  var username = document.getElementById("usernameRegisterInput").value;
  if (isUnsafe(username)) {
    feedback("Warning: enter a valid username (no funny characters, not blank)", true); 
    return;
  }
  var pwd = document.getElementById("passwordRegisterInput").value;
  if (!checkPasswordComplexity(pwd)) {
    feedback("Warning: enter a valid password at least 8 characters long" +
             " (include a lower case, uppercase, special !@#$%^&*, and number character)", true); 
             return;
  }
  var confirmPwd = document.getElementById("confirmPasswordRegisterInput").value;
  if (pwd != confirmPwd) {
    feedback("Warning: passwords do not match", true); 
    return;
  }
  if (false && document.getElementById("emailCodeRegisterInput").value != document.getElementById("emailCode").value) {
    feedback("Warning: email code validation failed", true); 
    return;
  }
  var obj =  { "Name": name, "Surname": surname, "Email": email, "Username": username, "Password": pwd, "ProfilePicture": "images/webcat.png" };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", {command: "register",  data: objStr }, function(data) {
     feedback(data, true);
     if (data.includes("Success")) {
       window.location.href = "index.html";
     }
  });
}

var loadPP = function(username) {
  var fn = "images/" + username + ".png";
  if (imageExists(fn)) {
    document.getElementById("userImage").src = fn;
  }
  else {
    document.getElementById("userImage").src = "images/webcat.png";
  }
}
// ====================================================================================

// Edit Information
// ====================================================================================
var loadInformation = function() {
  setupDatabase();
  document.getElementById("emailCode").value = Math.floor((Math.random() * 1000) + 1);
  $.post("databasing.php", {command: "user",  data: "" }, function(username) {
    if (isInvalid(username)) {
      window.location.href = "login.html";
    }
    else {
        loadPP(username);
        
        $.post("databasing.php", {command: "loaduser",  data: "" }, function(data) {
          var obj = JSON.parse(data);
          document.getElementById("nameEditInput").value = obj.Name;
          document.getElementById("surnameEditInput").value = obj.Surname;
          document.getElementById("emailEditInput").value = obj.EmailAddress;
          document.getElementById("usernameEditInput").value = obj.Username;
      });
    }
  });
}

var cancelEditInformation = function() {
  window.location.href = "index.html";
}

var editInformation = function() {
  var name = document.getElementById("nameEditInput").value;
  if (isUnsafe(name)) {
    feedback("Warning: enter a valid name (no funny characters, not blank)", true); 
    return;
  }
  var surname = document.getElementById("surnameEditInput").value;
  if (isUnsafe(surname)) {
    feedback("Warning: enter a valid surname (no funny characters, not blank)", true); 
    return;
  }
  var email = document.getElementById("emailEditInput").value;
  if (!checkEmailAddress(email)) {
    feedback("Warning: provide a valid email address in the format some.thing@address.com", true); 
    return;
  }
  var username = document.getElementById("usernameEditInput").value;
  if (isUnsafe(username)) {
    feedback("Warning: enter a valid username (no funny characters, not blank)", true); 
    return;
  }
  var obj =  { "Name": name, "Surname": surname, "Email": email, "Username": username, "ProfilePicture": "images/" + username + ".png" };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", {command: "save",  data: objStr }, function(data) {
     if (data.includes("Duplicate entry")) {
       feedback("Warning: Username already exists, choose another", true);
     }
     if (data.includes("Success")) {
       feedback("Success", true);
       window.location.href = "index.html";
     }
  });
}

var changePassword = function() {
  var pwd = document.getElementById("passwordEditInput").value;
  if (!checkPasswordComplexity(pwd)) {
    feedback("Warning: enter a valid password at least 8 characters long" +
             " (include a lower case, uppercase, special !@#$%^&*, and number character)", true); 
             return;
  }
  var confirmPwd = document.getElementById("confirmPasswordEditInput").value;
  if (pwd != confirmPwd) {
    feedback("Warning: passwords do not match", true); 
    return;
  }
  var obj =  { "Password": pwd  };
  var objStr = JSON.stringify(obj);
  $.post("databasing.php", {command: "password",  data: objStr }, function(data) {
     feedback(data, true);
     if (data.includes("Success")) {
       window.location.href = "config.html";
     }
  });
}

var gotoChangePassword = function() {
  window.location.href = "Password.html";
}
// ====================================================================================

// Change Password
// ====================================================================================
var loadPassword = function() {
  setupDatabase();
  $.post("databasing.php", {command: "user",  data: "" }, function(username) {
    if (isInvalid(username)) {
      window.location.href = "login.html";
    }
  });
}
// ====================================================================================

// Data handling
// ====================================================================================
function imageExists(image_url){
  try {
    var req = new XMLHttpRequest();
    req.open('HEAD', image_url, false);
    req.send();
  }
  catch (e) { } // suppress
  return req.status != 404;
}

var getUsername = function() {
  $.post("databasing.php", {command: "user",  data: "" }, function(data) {
    document.getElementById("usernameText").innerHTML =data;
  });
}

var getInfo = function() {
  getUsername();
  $.post("databasing.php", {command: "loaduser",  data: "" }, function(data) {
    var obj = JSON.parse(data);
    document.getElementById("infoText").innerHTML = obj.Name + " " + obj.Surname;
  });
}

var setupDatabase = function() {
  $.post("databasing.php", {command: "setup",  data: "" }, function(data) {
     feedback(data);
  });
}
// ====================================================================================

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

var clearFeedback = function() {
  feedback("", true);
}

// String checking
function isInvalid(str){
  return str.str === null || str.match(/^ *$/) !== null;
}

function isUnsafe(str){
  return isInvalid(str) || (str.match(/[\-=\[\]{};':"\\|,<>\/]/));
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
  return (performance.now() - t0).toPrecision(3);
}
// ====================================================================================

// SMTP
// ====================================================================================
var emailPost = function() {
  var obj = { "EmailAddress": document.getElementById("emailText").value, 
              "Message": document.getElementById("chirpInput").value };
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