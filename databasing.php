<?php
  include 'mysql.php';
  $commandStr = $_POST['command'];
  $data = $_POST['data'];
  $obj = json_decode($_POST['data'], false);
  $returnVal;
  switch ($commandStr) {
    case "setup": $returnVal = MySqlClass::setupDatabase(); break;
    case "chirp": $returnVal = MySqlClass::createPost($data); break;
    case "load": $returnVal = MySqlClass::loadAllPosts(); break;
    case "register": $returnVal = MySqlClass::registerUser($obj); break;
    case "login": $returnVal = MySqlClass::authenticateUser($obj); break;
    case "logout": $returnVal = MySqlClass::unsetUsername($obj); break;
    case "user": $returnVal = MySqlClass::getUsername(); break;
    case "save": $returnVal = MySqlClass::saveInformation($obj); break;
    case "loaduser": $returnVal = MySqlClass::loadUser(MySqlClass::getUsername()); break;
    case "email": $returnVal = MySqlClass::emailPost($obj); break;
    case "cookie": $returnVal = MySqlClass::cookieUser($data); break;
  }
  die($returnVal);
?>