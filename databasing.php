<?php
  include 'mysql.php';
  $commandStr = $_POST['command'];
  $obj = json_decode($_POST['object'], false);
  $returnVal;
  
  switch ($commandStr) {
    case "setup": $returnVal = MySqlClass::setupDatabase(); break;
    
    case "create": 
    $date = new DateTime($obj->dateOfBirth);
    $newdate = $date->format('Y-m-d');
    $returnVal = MySqlClass::createPerson($obj->name, $obj->surname, $newdate, $obj->emailAddress, $obj->age); 
    break;
    
    case "load": $returnVal = MySqlClass::loadPerson($obj->name, $obj->surname); break;
    
    case "save": $returnVal = MySqlClass::savePerson($obj->name, $obj->surname, $obj->dateOfBirth, $obj->emailAddress, $obj->age); break;
    
    case "delete": $returnVal = MySqlClass::deletePerson($obj->name, $obj->surname); break;
    
    case "loadAll": $returnVal = MySqlClass::loadAll(); break;
    
    case "deleteAll": $returnVal = MySqlClass::deleteAll(); break;
    
  }
  die($returnVal);
?>