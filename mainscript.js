var main = function() {
  setupDatabase();
  loadAllPeople(callback);
}

var setupDatabase = function() {
  $.post("databasing.php", {command: "setup",  object: "", misc: "" }, function(data) {
     document.getElementById('outputText').innerHTML = data;
  });
}

var loadAllPeople = function(callback) {
  var json = JSON.stringify({name:"", surname:"", dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "loadAll",  object: json, misc: "" }, function(data) {
    console.log(data);
     callback(data);
  });
}

var callback = function(value) {
  var table = document.getElementById("peopleTable");
  var tableRows = table.getElementsByTagName('tr');
  for (var x = tableRows.length - 1; x > 0; x--) {
     table.removeChild(tableRows[x]);
  }
  var array = JSON.parse(value);
  var r = 0;
  array.forEach(function(obj) {
    var tr = document.createElement("tr");
    table.appendChild(tr);
    var c = 0;
    for (var prop in obj) {
      var td = document.createElement('td');
      td.innerHTML = obj[prop];
      td.id = "r" + r + "c" + c;
      td.onclick = function() { saveItem(this.id); };
      tr.appendChild(td);
      c++;
    }
    var tdbtn = document.createElement('td');
    tdbtn.innerHTML = "Delete";
    tdbtn.id = "r" + r + "delete";
    tdbtn.style.width = 10;
    tdbtn.onclick = function() { deleteRow(this.id); };
    tr.appendChild(tdbtn);
    r++;
  });
}

var rowArray = function(r) {
  var array = [];
  for (var c = 0; c < 5; c++) {
    array.push(document.getElementById("r" + r + "c" + c).innerHTML);
  }
  return array;
}

var saveItem = function(id){
  var cmd;
  var col = id.substring(3,4);
  var colArray = [ "Name", "Surname", "DateOfBirth", "EmailAddress", "Age" ];
  var colName = colArray[col]; 
  var r = id.substring(1,2);
  var array = rowArray(r);
  var newValue = prompt("Enter new value:", document.getElementById("r" + r + "c" + col).innerHTML);
  savePerson(array[0], array[1], array[2], array[3], array[4], colName + "=\'" + newValue + "\'");
}

var savePerson = function(n, s, d, e, a, m) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:d, emailAddress:e, age:a});
  $.post("databasing.php", {command: "save",  object: json, misc: m }, function(data) {
     document.getElementById('outputText').innerHTML = data;
     loadAllPeople(callback);
  });
}

var createForm = function() {
  document.getElementById('createForm').style.display = "block";
}

var loadAll = function() {
  var t0 = performance.now();
  loadAllPeople(callback);
  document.getElementById('outputTimer').innerHTML = "Time: " + (performance.now() - t0) + "ms";
}

var deleteAll = function() {
  var json = JSON.stringify({name:"", surname:"", dateOfBirth:"", emailAddress:"", age:""});
  $.post("databasing.php", {command: "deleteAll",  object: json, misc:"" }, function(data) { loadAllPeople(callback); });  
}

var clearOutput = function() {
  document.getElementById('outputText').innerHTML = "";
  document.getElementById('outputTimer').innerHTML = "";
}

var inputPerson = function() {
  var json = JSON.stringify({name: document.getElementById('nameInput').value, 
                             surname: document.getElementById('surnameInput').value, 
                             dateOfBirth: document.getElementById('dateOfBirthInput').value, 
                             emailAddress: document.getElementById('emailAddressInput').value, 
                             age: document.getElementById('ageInput').value});
  $.post("databasing.php", {command: "create",  object: json, misc: "" }, function(data) {
     document.getElementById('outputText').innerHTML = data;
     loadAllPeople(callback);
  });
}

var createPerson = function(n, s, d, e, a) {
  var json = JSON.stringify({name: n, surname: s, dateOfBirth: d, emailAddress: e, age: a});
  $.post("databasing.php", {command: "create",  object: json, misc: "" }, function(data) {
     document.getElementById('outputText').innerHTML = data;
     loadAllPeople(callback);
  });
}

var people = [ // TODO have this array in PHP - ramdonized values
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

var deleteRow = function(id) {
  var r = id.substring(1,2);
  var array = rowArray(r);
  if (window.confirm(array[0] + " " + array[1] + " " +array[2] + " " +array[3] + " " +array[4] + 
                     "\nAre you sure you want to delete?\n")) {
    deletePerson(array[0], array[1], array[2], array[3], array[4]);
  }
}

var deletePerson = function(n, s, d, e, a) {
  var json = JSON.stringify({name:n, surname:s, dateOfBirth:d, emailAddress:e, age:a});
  $.post("databasing.php", {command: "delete",  object: json, misc: "" }, function(data) {
     document.getElementById('outputText').innerHTML = data;
     loadAllPeople(callback);
  });
}