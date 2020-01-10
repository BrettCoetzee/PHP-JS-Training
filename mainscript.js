const NAME_COL = 0;
const SURNAME_COL = 1;
const DoB_COL = 2;
const EMAIL_COL = 3;
const AGE_COL = 4;
const DEL_COL = 5;

var main = function() {
  setupDatabase();
  loadAllPeople(reloadTableCallback);
}

var closeCreateForm = function() {
  document.getElementById('createForm').style.display = "none";
}

var feedback = function(data) {
  var nameStr = 'feedbackText';
  document.getElementById(nameStr).innerHTML = data;
  if (data.includes("Error")) {
    document.getElementById(nameStr).style.color = "red";
  }
  else if (data.includes("Success")) {
    document.getElementById(nameStr).style.color = "lightgreen";
  }
  else if (data.includes("Warning")) {
    document.getElementById(nameStr).style.color = "yellow";
  }  
  else {
    document.getElementById(nameStr).style.color = "white";
  }
}

var t0 = 0;
var startTimer = function() {
  t0 = performance.now();
}

var elapsedTime = function(){
  document.getElementById('feedbackTimer').innerHTML = "Elapsed: " + (performance.now() - t0).toPrecision(3) + "ms";
}

var setupDatabase = function() {
  $.post("databasing.php", {command: "setup",  object: "", misc: "" }, function(data) {
     feedback(data);
  });
}

var loadAllPeople = function(reloadTableCallback) {
  var json = JSON.stringify({name:"", surname:"", dateOfBirth:"", emailAddress:"", age:""});
  startTimer();
  $.post("databasing.php", {command: "loadAll",  object: json, misc: "" }, function(data) {
     elapsedTime();
     reloadTableCallback(data);
  });
}

var reloadTableCallback = function(value) {
  var peopleTable = document.getElementById("peopleTable");
  var tableRows = peopleTable.getElementsByTagName('tr');
  for (var child = tableRows.length - 1; child > 0; child--) {
     peopleTable.removeChild(tableRows[child]);
  }
  var rowArray = JSON.parse(value);
  var rowInt = 0;
  rowArray.forEach(function(obj) {
    var tr = document.createElement("tr");
    peopleTable.appendChild(tr);
    var colInt = 0;
    for (var prop in obj) {
      var td = document.createElement('td');
      td.innerHTML = obj[prop];
      td.id = "c" + colInt + "r" + rowInt;
      td.onclick = function() { saveItem(this.id); };
      if (colInt == AGE_COL) {
        td.style.cursor = "not-allowed";
      }
      tr.appendChild(td);
      colInt++;
    }
    var tdbtn = document.createElement('td');
    tdbtn.innerHTML = "";
    tdbtn.id = "d" + rowInt;
    var img = document.createElement('img');
    img.src = "http://localhost/projects/dev/bin.png";
    img.width = 20;
    img.height = 20;
    tdbtn.appendChild(img);
    tdbtn.style.width = 10;
    tdbtn.style.textAlign = "center";
    tdbtn.onclick = function() { deleteRow(this.id); };
    tr.appendChild(tdbtn);
    rowInt++;
  });
}

var getRowArray = function(rowInt) {
  var rowArray = [];
  for (var colInt = 0; colInt < 5; colInt++) {
    rowArray.push(document.getElementById("c" + colInt + "r" + rowInt).innerHTML);
  }
  return rowArray;
}

var checkDate = function(dateStr) {
  if (new Date(dateStr) > new Date() || !dateStr.match(/^\d{4}-\d{2}-\d{2}$/i)) {
    feedback("Warning: Please choose a date that is earlier than today, and in the format YYYY-MM-DD");
    return false;
  }
  return true;
}

var checkEmailAddress = function(emailStr) {
  if (!emailStr.match(/^[A-Za-z0-9\.]+@[A-Za-z0-9]+\.[A-Za-z0-9]+$/i)) {
    feedback("Warning: Please provide a valid email address in the format some.thing@address.com");
    return false;
  }
  return true;
}

var saveItem = function(id){
  var colInt = id.substring(1,2);
  var colArray = [ "Name", "Surname", "DateOfBirth", "EmailAddress", "Age" ];
  var colName = colArray[colInt]; 
  var rowInt = id.substring(3,id.length);
  var array = getRowArray(rowInt);
  var newValue = prompt("Enter new value:", document.getElementById("c" + colInt + "r" + rowInt).innerHTML);
  if (newValue == null) {
    return;
  }
  if (colInt == DoB_COL && !checkDate(newValue)) {
    return;
  }
  if (colInt == EMAIL_COL && !checkEmailAddress(newValue)) {
    return;
  }
  if (isEmpty(newValue)) {
    feedback("Warning: Please enter a value (not empty text)");
    return;
  }
  var misc = colName + "=\'" + newValue + "\'"; 
  if (colInt == DoB_COL) {
    misc += ", Age=" + getAgeFromDate(newValue);
  }
  savePerson(array[NAME_COL], array[SURNAME_COL], array[DoB_COL], array[EMAIL_COL], array[AGE_COL], misc);
  
}

var savePerson = function(nameStr, surnameStr, dateStr, emailStr, ageStr, miscStr) { 
  var json = JSON.stringify({name: nameStr, surname: surnameStr, dateOfBirth: dateStr, emailAddress: emailStr, age: ageStr});
  $.post("databasing.php", {command: "save",  object: json, misc: miscStr }, function(data) {
     feedback(data);
     loadAllPeople(reloadTableCallback);
  });
}

var createForm = function() {
  document.getElementById('createForm').style.display = "block";
}

var deleteAll = function() {
  if (window.confirm("Are you sure you want to delete all people?\n")) {
    var json = JSON.stringify({ name:"", surname:"", dateOfBirth:"", emailAddress:"", age:"" });
    startTimer();
    $.post("databasing.php", { command: "deleteAll",  object: json, misc: "" }, function(data) {
      feedback(data);
      elapsedTime();
      loadAllPeople(reloadTableCallback);
    });
  }
}

function isEmpty(str){
  return str === null || str.match(/^ *$/) !== null;
}

function getAgeFromDate(dateStr) {
    var current = new Date();
    var bday = new Date(dateStr);
    var age = current.getFullYear() - bday.getFullYear();
    var m = current.getMonth() - bday.getMonth();
    if (m < 0 || (m === 0 && current.getDate() < bday.getDate())) {
        age = age - 1;
    }
    return age;
}

var inputPerson = function() {
  var nameStr = document.getElementById('nameInput').value;
  var surnameStr = document.getElementById('surnameInput').value;
  var dateStr = document.getElementById('dateOfBirthInput').value;
  var emailStr = document.getElementById('emailAddressInput').value;
  var ageStr = getAgeFromDate(dateStr);
  document.getElementById('createForm').addEventListener('submit', function(event){event.preventDefault();});
  if (isEmpty(nameStr)) {
    feedback("Warning: Please enter a value for name (not empty text)");
    return;
  }
  if (isEmpty(surnameStr)) {
    feedback("Warning: Please enter a value for surname (not empty text)");
    return;
  }
  if (!checkDate(dateStr) || !checkEmailAddress(emailStr)) {
    return;
  }
  createPerson(nameStr, surnameStr, dateStr, emailStr, ageStr, true);
  document.getElementById('createForm').style.display = "none";
}

var peopleArray = [
  { Name:"Brett1", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett1.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett2", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett2.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett3", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett3.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett4", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett4.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett5", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett5.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett6", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett6.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett7", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett7.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett8", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett8.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett9", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett9.coetzee@stratusolve.com", Age:32 },
  { Name:"Brett0", Surname:"Coetzee", DateOfBirth:"1987-08-03", EmailAddress:"brett0.coetzee@stratusolve.com", Age:32 }
];

var loadPerson = function(emailStr) {
  var json = JSON.stringify({name: "", surname: "", dateOfBirth: "", emailAddress: emailStr, age: ""});
  $.post("databasing.php", {command: "load",  object: json, misc: "" }, function(data) {
     feedback(data);
  });
}

var createPerson = function(nameStr, surnameStr, dateStr, emailStr, ageStr, reportBool) {
  var json = JSON.stringify({name: nameStr, surname: surnameStr, dateOfBirth: dateStr, emailAddress: emailStr, age: ageStr});
  $.post("databasing.php", {command: "create",  object: json, misc: "" }, function(data) {
     if (reportBool) {
       feedback(data);
     }
     loadAllPeople(reloadTableCallback);
  });
}

var create10people = function() {
  startTimer();
  peopleArray.forEach(function(p) {
    createPerson(p.Name, p.Surname, p.DateOfBirth, p.EmailAddress, p.Age, false);
  });
  elapsedTime();
  feedback("Success creating 10 people");
}

var deleteRow = function(id) {
  var rowInt = id.substring(1,id.length);
  var rowArray = getRowArray(rowInt);
  if (window.confirm(rowArray[NAME_COL] + " " + 
                     rowArray[SURNAME_COL] + " " + 
                     rowArray[DoB_COL] + " " + 
                     rowArray[EMAIL_COL] + " " + 
                     rowArray[AGE_COL] + 
                     "\nAre you sure you want to delete?\n")) {
    deletePerson(rowArray[NAME_COL], rowArray[SURNAME_COL], rowArray[DoB_COL], rowArray[EMAIL_COL], rowArray[AGE_COL]);
  }
}

var deletePerson = function(nameStr, surnameStr, dateStr, emailStr, ageStr) {
  var json = JSON.stringify({name: nameStr, surname: surnameStr, dateOfBirth: dateStr, emailAddress: emailStr, age: ageStr});
  $.post("databasing.php", {command: "delete",  object: json, misc: "" }, function(data) {
     feedback(data);
     loadAllPeople(reloadTableCallback);
  });
}