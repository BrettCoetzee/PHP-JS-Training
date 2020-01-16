<?php
session_start();

class MySqlClass {
  public static $Connection;
  
  public function establishDatabasing() {
    self::$Connection = new mysqli("localhost", "root", "password");
    if (self::$Connection->connect_error) {
      die("Connection failed: " . self::$Connection->connect_error . "<br>");
    }
    $sql = "CREATE DATABASE IF NOT EXISTS chirpdb";
    if (self::$Connection->query($sql) !== TRUE) {
      echo "Error creating database: " . self::$Connection->error . "<br>";
    }
    self::$Connection = new mysqli("localhost", "root", "password", "chirpdb");
  }
  
  function closeDatabasing() {
    self::$Connection->close();
  }
    
  function setupDatabase() {
    self::createUsersTable();
    self::createPostsTable();
  }
  
  function createUsersTable() {
    self::establishDatabasing();
    if (!self::$Connection->query('select 1 from `Users` LIMIT 1')) {
      $sql = "CREATE TABLE Users ( 
              Name VARCHAR(30) NOT NULL, 
              Surname VARCHAR(30) NOT NULL, 
              EmailAddress CHARACTER VARYING(50) NOT NULL, 
              Username VARCHAR(30) NOT NULL PRIMARY KEY, 
              Password CHARACTER VARYING(255) NOT NULL)";
      if (self::$Connection->query($sql)) {
        echo "Success creating Users table<br>";
      }
      else {
        echo "Error creating Users table: " . self::$Connection->error . "<br>";
      }
    }
    self::closeDatabasing();
  }
  
  function createPostsTable(){
    self::establishDatabasing();
    if(!self::$Connection->query('select 1 from `Posts` LIMIT 1'))
    {
      $sql = "CREATE TABLE Posts ( 
      UserId VARCHAR(30) NOT NULL,
      PostText CHARACTER VARYING(1000) NOT NULL,
      PostTimeStamp TIMESTAMP PRIMARY KEY)";
      if (self::$Connection->query($sql)) {
        echo "Success creating Posts table<br>";
      }
      else {
        echo "Error creating Posts table: " . self::$Connection->error . "<br>";
      }
    }
    self::closeDatabasing();
  }
  
  function loadUser($username) {
    self::establishDatabasing();
    $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $username . '\';';
    $qryResult = self::$Connection->query($loadQry);
    while($row = $qryResult->fetch_assoc()) {
      self::closeDatabasing();
      return "{\"Name\":\"" . $row["Name"] . 
             "\",\"Surname\":\"" . $row["Surname"] . 
             "\",\"EmailAddress\":\"" . $row["EmailAddress"] . 
             "\",\"Password\":\"" . $row["Password"] . "\"}";
    }
    self::closeDatabasing();
    return "";
  }
  
  function checkUser($username) {
    self::establishDatabasing();
    $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $username . '\';';
    $qryResult = self::$Connection->query($loadQry);
    while($row = $qryResult->fetch_assoc()) {
      self::closeDatabasing();
      return true;
    }
    self::closeDatabasing();
    return false;
  }
  
  function getUsername() {
    if (isset($_SESSION["username"])) {
      return $_SESSION["username"];
    } else if (isset($_COOKIE["chirpusername"])) {
      return $_COOKIE["chirpusername"];
    }
    return "";
  }
  
  function cookieUser($username) {
    setcookie("chirpusername", $username, time() + (86400 * 30), '/');
    return "Success setting cookie";
  }

  function unsetUsername() {
    unset($_SESSION["username"]);
    setcookie("chirpusername", "",  -1, '/');
    return "unset cookie";
  }
  
  function authenticateUser($data) {
    if (!self::checkUser($data->Username)) {
      return "Warning: Username " . $data->Username . 
             " does not exist! Please try another username or register a new user.<br>";
    }
    self::establishDatabasing();
    $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $data->Username . '\';';
    $qryResult = self::$Connection->query($loadQry);
    while($row = $qryResult->fetch_assoc()) {
      self::closeDatabasing();
      if (password_verify($data->Password, $row["Password"])) {
        $_SESSION["username"] = $data->Username;
        return "Success authenticating " . $data->Username . "<br>";
      }
      else {
        return "Warning: Incorrect password";
      }
    }
    self::closeDatabasing();
    return "Warning: Incorrect password";
  }
  
  function saveInformation($data) {
    self::establishDatabasing();
    $saveQry = 'UPDATE Users ' . 
               'SET Name=\'' . $data->Name . 
               '\', Surname=\'' . $data->Surname .
               '\', EmailAddress=\'' . $data->Email .
               '\', Password=\'' . password_hash($data->Password, PASSWORD_DEFAULT) .
               '\' WHERE Username=\'' . $data->Username  . '\';';
    echo $saveQry;
    if (self::$Connection->query($saveQry)) {
      echo "Success saving information<br>";
    }
    else {
      echo "Error saving information: " . self::$Connection->error;
    }
    self::closeDatabasing();
  }
 
  function registerUser($data) {
    if (!self::checkUser($data->Username)) {
      self::establishDatabasing();
      $entry = '\'' . $data->Name . 
               '\', \'' . $data->Surname .
               '\', \'' . $data->Email .
               '\', \'' . $data->Username .
               '\', \'' . password_hash($data->Password, PASSWORD_DEFAULT) . '\'';
      $insertQry =  'INSERT INTO Users VALUES (' . $entry . ');';
      echo $insertQry;
      if (self::$Connection->query($insertQry)) {
        echo "Success creating " . $entry . "<br>";
      }
      else {
        echo "Error resitering user: " . self::$Connection->error . "<br>";
      }
      self::closeDatabasing();
    }
    else {
      echo "Error registering user: " . $data->Username . 
           " already exists. Please specify a new username.<br>";
    }
  }
  
  function createPost($data) {
    $username = $_SESSION["username"];
    self::establishDatabasing();
    $entry = '\'' . $username . '\', \'' . $data . '\', now()';
    $insertQry =  'INSERT INTO Posts VALUES (' . $entry . ');';
    if (self::$Connection->query($insertQry)) {
      echo "Success creating " . $entry . "<br>";
    }
    else {
      echo "Error creating row: " . self::$Connection->error . "<br>";
    }
    self::closeDatabasing();
  }
  
  function loadAllPosts() {
    self::establishDatabasing();
    $loadQry = 'SELECT * FROM Posts;';
    $qryResult = self::$Connection->query($loadQry);
    $first = true;
    echo "[";
    while($row = $qryResult->fetch_assoc()) {
      if ($first != true) {
        echo ',';
      }
      echo "{\"UserId\":\"" . $row["UserId"] . 
           "\",\"PostText\":\"" . $row["PostText"] . 
           "\",\"PostTimeStamp\":\"" . $row["PostTimeStamp"] . "\"}";
      $first = false;
    }
    echo "]";
    self::closeDatabasing();
  }
  
  // TODO
  function emailUser($address) {
    // SMTP server is taking too much time to integrate
    // Goto php.ini and search SMTP and openssl
    mail($address, "Test", "Hi", "From: brett.coetzee@stratusolve.com");
  }
}
?>