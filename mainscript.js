var main = function() {
  setupDatabase();
}

var save = function() {
  savePerson("Brett1", "Coetzee", "1987-08-03", "brett1.coetzee@stratusolve.com", 11);
}

var load = function() {
  loadPerson("Brett1", "Coetzee");
}

var loadAll = function() {
  var t0 = performance.now();
  loadAllPeople();
  document.getElementById('outputTimer').innerHTML = "Time: " + (performance.now() - t0) + "ms";
}

var deleteP = function() {
  deletePerson("Brett2", "Coetzee");
}

var deleteAll = function() {
  var t0 = performance.now();
  deleteAllPeople();
  document.getElementById('outputTimer').innerHTML = "Time: " + (performance.now() - t0) + "ms";
}

var clearOutput = function() {
  document.getElementById('outputText').innerHTML = "";
  document.getElementById('outputTimer').innerHTML = "";
}

var setupDatabase = function() {
  $.post("databasing.php", {command: "setup",  object: "" }, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var createPerson = function(n, s, d, e, a) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:d, emailAddress:e, age:a});
  $.post("databasing.php", {command: "create",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var people = [ 
  { Name:"Brett1", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett1.coetzee@stratusolve.com", Age:21 },
  { Name:"Brett2", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett2.coetzee@stratusolve.com", Age:22 },
  { Name:"Brett3", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett3.coetzee@stratusolve.com", Age:23 },
  { Name:"Brett4", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett4.coetzee@stratusolve.com", Age:24 },
  { Name:"Brett5", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett5.coetzee@stratusolve.com", Age:25 },
  { Name:"Brett6", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett6.coetzee@stratusolve.com", Age:26 },
  { Name:"Brett7", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett7.coetzee@stratusolve.com", Age:27 },
  { Name:"Brett8", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett8.coetzee@stratusolve.com", Age:28 },
  { Name:"Brett9", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett9.coetzee@stratusolve.com", Age:29 },
  { Name:"Brett0", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett0.coetzee@stratusolve.com", Age:30 }
];
var create10people = function() {
  var t0 = performance.now();
  people.forEach(function(p) {
    createPerson(p.Name, p.Surname, p.DateOfBirth, p.EmailAddress, p.Age);
  });
  document.getElementById('outputTimer').innerHTML = "Time: " + (performance.now() - t0) + "ms";
}

var loadPerson = function(n, s) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "load",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var savePerson = function(n, s, d, e, a) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:d, emailAddress:e, age:a});
  $.post("databasing.php", {command: "save",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var deletePerson = function(n, s) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "delete",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var loadAllPeople = function() {
  var json = JSON.stringify({name:"", surname:"", dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "loadAll",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}

var deleteAllPeople = function() {
  var json = JSON.stringify({name:"", surname:"", dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "deleteAll",  object: json}, function(data) {
     document.getElementById('outputText').innerHTML += data;
  });
}