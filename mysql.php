<?php
  // notes:
  // Using XAMPP as Apache and MySQL server
  // Open mysql database and run the following SQL command:
  // SET Password=PASSWORD('password');
  // Then in C:\xampp\phpMyAdmin\config.inc.php:
  // $cfg['Servers'][$i]['password'] = 'password';
  // Table saved on disk at C:\xampp\mysql\data\mysql      
  class MySqlClass {
    
    public static $serverName = "localhost";
    public static $username = "root";
    public static $password = "password";
    public static $dbName = "mysql"; // TODO Create new database
    public static $tableName = "Person";
    public static $Connection;
    
    public function establishDatabasing() {
      self::$Connection = new mysqli(self::$serverName, self::$username, self::$password, self::$dbName);
      if (self::$Connection->connect_error) {
        die("Connection failed: " . self::$Connection->connect_error . "<br>");
      }
    }
    
    function closeDatabasing() {
      self::$Connection->close();
    }
    
    function setupDatabase(){
      self::establishDatabasing();
      if(!self::$Connection->query('select 1 from `' . self::$tableName . '` LIMIT 1'))
      { // TODO ID as primary key
        $sql = "CREATE TABLE " . self::$tableName . " (
        Name VARCHAR(30) NOT NULL,
        Surname VARCHAR(30) NOT NULL,
        DateOfBirth DATE,
        EmailAddress CHARACTER VARYING(50) NOT NULL PRIMARY KEY,
        Age int UNSIGNED
        )";
        if (self::$Connection->query($sql)) {
          echo "Table " . self::$tableName . " created successfully<br>";
        }
        else {
          echo "Error creating table: " . self::$Connection->error . "<br>";
        }
      }
      self::closeDatabasing();
    }
    
    function createPerson($name, $surname, $dateOfBirth, $emailAddress, $age) {
      self::establishDatabasing();
      $entry = '\'' . $name . '\', \'' . $surname . '\', \'' . $dateOfBirth . '\', \'' . 
               $emailAddress . '\', ' . $age;
      $insertQry =  'INSERT INTO ' . self::$tableName . ' VALUES (' . $entry . ');';
      if (self::$Connection->query($insertQry)) {
        echo "[" . $entry . "] added to " . self::$tableName . "<br>";
      }
      else {
        echo "Error creating row: " . self::$Connection->error . "<br>";
      }
      self::closeDatabasing();
    }
    
    function loadPerson($name, $surname) {
      self::establishDatabasing();
      $loadQry = 'SELECT * FROM ' . self::$tableName . ' WHERE Name=\'' . $name . 
                 '\' AND Surname=\'' . $surname . '\';';
      $qryResult = self::$Connection->query($loadQry);
      while($row = $qryResult->fetch_assoc()) {
        echo '[' . $row["Name"] . ", " . $row["Surname"]. ", " . $row["DateOfBirth"] . ", " . 
             $row["EmailAddress"] . ", " . $row["Age"] ."]<br>";
      }
      self::closeDatabasing();
    }
    
    function savePerson($update, $name, $surname, $dateOfBirth, $emailAddress, $age) {
      self::establishDatabasing();   
      $saveQry = 'UPDATE ' . self::$tableName . 
                 ' SET ' . $update . 
                 ' WHERE Name=\'' . $name . 
                 '\' AND Surname=\'' . $surname . 
                 '\' AND DateOfBirth=\'' . $dateOfBirth .
                 '\' AND EmailAddress=\'' . $emailAddress .
                 '\' AND Age=' . $age . ';';
      if (self::$Connection->query($saveQry)) {
        echo "Save successful<br>" . $saveQry;;
      }
      else {
          echo "Error saving: " . self::$Connection->error . "<br>";
      }
      self::closeDatabasing();
    }
    
    function deletePerson($name, $surname, $dateOfBirth, $emailAddress, $age) {
      self::establishDatabasing();
      $delQry = 'DELETE FROM ' . self::$tableName . 
                 ' WHERE Name=\'' . $name . 
                 '\' AND Surname=\'' . $surname . 
                 '\' AND DateOfBirth=\'' . $dateOfBirth .
                 '\' AND EmailAddress=\'' . $emailAddress .
                 '\' AND Age=' . $age . ';';
      if (self::$Connection->query($delQry)) {
        echo "Delete successful<br>" + $delQry;
      }
      else {
        echo "Error deleting: " . self::$Connection->error . "<br>";
      }
      self::closeDatabasing();
    }
    
    function loadAll() {
      self::establishDatabasing();
      $loadQry = 'SELECT * FROM ' . self::$tableName . ';';
      $qryResult = self::$Connection->query($loadQry);
      $first = true;
      echo "[";
      while($row = $qryResult->fetch_assoc()) {
        if ($first != true) {
          echo ',';
        }
        echo "{\"Name\":\"" . $row["Name"] . 
                   "\",\"Surname\":\"" . $row["Surname"] . 
                   "\",\"DateOfBirth\":\"" . $row["DateOfBirth"] . 
                   "\",\"EmailAddress\":\"" . $row["EmailAddress"] . 
                   "\",\"Age\":" . $row["Age"] . "}";
        $first = false;
      }
      echo "]";
      self::closeDatabasing();
    }
    
    function deleteAll() {
      self::establishDatabasing();
      $loadQry = 'DELETE FROM ' . self::$tableName . ';';
      if (self::$Connection->query($loadQry)) {
        echo "All rows deleted<br>";
      }
      else {
        echo "Error deleting all: " . self::$Connection->error . "<br>";
      }
      self::closeDatabasing();
    }
  }
?>