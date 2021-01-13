<?php
session_start();
class MySqlClass {
    // Generic
    protected static $Connection;
    public static function establishDatabasing() {
        $DatabaseNameStr = 'webcat_db';
        self::$Connection = new mysqli("localhost", "root", "password");
        if (self::$Connection->connect_error) {
            die("Connection failed: " . self::$Connection->connect_error . "<br>");
        }
        $sql = "CREATE DATABASE IF NOT EXISTS ".$DatabaseNameStr;
        if (self::$Connection->query($sql) !== TRUE) {
            echo "Error creating database: " . self::$Connection->error . "<br>";
        }
        self::$Connection = new mysqli("localhost", "root", "password", $DatabaseNameStr);
    }
    public static function closeDatabasing() {
        self::$Connection->close();
    }
    public static function setupDatabase() {
        self::createUsersTable();
        self::createPostsTable();
        self::setupAppDatabase();
    }
    public static function createUsersTable() {
        self::establishDatabasing();
        if (!self::$Connection->query('select 1 from `Users` LIMIT 1')) {
            $sql = "CREATE TABLE Users ( 
              Name VARCHAR(30) NOT NULL, 
              Surname VARCHAR(30) NOT NULL, 
              EmailAddress CHARACTER VARYING(50) NOT NULL, 
              Username VARCHAR(30) NOT NULL PRIMARY KEY, 
              Password CHARACTER VARYING(255) NOT NULL,
              ProfilePicture CHARACTER VARYING(200) NOT NULL)";
            if (self::$Connection->query($sql)) {
                echo "Success creating Users table<br>";
            } else {
                echo "Error creating Users table: " . self::$Connection->error . "<br>";
            }
        }
        self::closeDatabasing();
    }
    public static function createPostsTable() {
        self::establishDatabasing();
        if (!self::$Connection->query('select 1 from `Posts` LIMIT 1')) {
            $sql = "CREATE TABLE Posts ( 
                      UserId VARCHAR(30) NOT NULL,
                      PostText TEXT(65535),
                      CommandText TEXT(65535),
                      CommandInt int,
                      PostTimeStamp TIMESTAMP PRIMARY KEY)";
            if (self::$Connection->query($sql)) {
                echo "Success creating Posts table<br>";
            } else {
                echo "Error creating Posts table: " . self::$Connection->error . "<br>";
            }
        }
        self::closeDatabasing();
    }
    public static  function loadUser($username) {
        self::establishDatabasing();
        $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $username . '\';';
        $qryResult = self::$Connection->query($loadQry);
        while ($row = $qryResult->fetch_assoc()) {
            self::closeDatabasing();
            return "{\"Name\":\"" . filter_var($row["Name"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"Surname\":\"" . filter_var($row["Surname"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"EmailAddress\":\"" . filter_var($row["EmailAddress"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"Username\":\"" . $row["Username"] . "\"}";
        }
        self::closeDatabasing();
        return "";
    }
    public static function checkUser($username) {
        self::establishDatabasing();
        $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $username . '\';';
        $qryResult = self::$Connection->query($loadQry);
        while ($row = $qryResult->fetch_assoc()) {
            self::closeDatabasing();
            return true;
        }
        self::closeDatabasing();
        return false;
    }
    public static function getUsername() {
        if (isset($_SESSION["username"])) {
            return $_SESSION["username"];
        } else if (isset($_COOKIE["chirpusername"])) {
            return $_COOKIE["chirpusername"];
        }
        return "";
    }
    public static function cookieUser($username) {
        setcookie("chirpusername", $username, time() + (86400 * 30), '/');
        return "Success setting cookie";
    }
    public static function unsetUsername() {
        unset($_SESSION["username"]);
        setcookie("chirpusername", "", -1, '/');
        return "unset cookie";
    }
    public static function authenticateUser($data) {
        if (!self::checkUser($data->Username)) {
            return "Warning: Incorrect username or password";
        }
        self::establishDatabasing();
        $loadQry = 'SELECT * FROM Users WHERE Username=\'' . $data->Username . '\';';
        $qryResult = self::$Connection->query($loadQry);
        while ($row = $qryResult->fetch_assoc()) {
            self::closeDatabasing();
            if (password_verify($data->Password, $row["Password"])) {
                $_SESSION["username"] = $data->Username;
                return "Success<br>";
            } else {
                return "Warning: Incorrect username or password";
            }
        }
        self::closeDatabasing();
        return "Warning: Incorrect username or password";
    }
    public static function saveInformation($data) {
        self::establishDatabasing();
        $saveQry = 'UPDATE Users ' .
            'SET Name=\'' . filter_var($data->Name, FILTER_SANITIZE_MAGIC_QUOTES) .
            '\', Surname=\'' . filter_var($data->Surname, FILTER_SANITIZE_MAGIC_QUOTES) .
            '\', EmailAddress=\'' . filter_var($data->Email, FILTER_SANITIZE_MAGIC_QUOTES) .
            '\', Username=\'' . filter_var($data->Username, FILTER_SANITIZE_MAGIC_QUOTES) .
            '\', ProfilePicture=\'' . filter_var($data->ProfilePicture, FILTER_SANITIZE_MAGIC_QUOTES) .
            '\' WHERE Username=\'' . $_SESSION["username"] . '\';';
        if (self::$Connection->query($saveQry)) {
            $_SESSION["username"] = $data->Username;
            echo "Success<br>";
        } else {
            echo "Error saving information: " . self::$Connection->error;
        }
        self::closeDatabasing();
    }
    public static function savePassword($data) {
        self::establishDatabasing();
        $saveQry = 'UPDATE Users ' .
            'SET Password=\'' . password_hash($data->Password, PASSWORD_DEFAULT) .
            '\' WHERE Username=\'' . $_SESSION["username"] . '\';';
        if (self::$Connection->query($saveQry)) {
            echo "Success<br>";
        } else {
            echo "Error saving information: " . self::$Connection->error;
        }
        self::closeDatabasing();
    }
    public static  function registerUser($data) {
        if (!self::checkUser($data->Username)) {
            self::establishDatabasing();
            $entry = '\'' . filter_var($data->Name, FILTER_SANITIZE_MAGIC_QUOTES) .
                '\', \'' . filter_var($data->Surname, FILTER_SANITIZE_MAGIC_QUOTES) .
                '\', \'' . filter_var($data->Email, FILTER_SANITIZE_MAGIC_QUOTES) .
                '\', \'' . filter_var($data->Username, FILTER_SANITIZE_MAGIC_QUOTES) .
                '\', \'' . password_hash($data->Password, PASSWORD_DEFAULT) .
                '\', \'' . filter_var($data->ProfilePicture, FILTER_SANITIZE_MAGIC_QUOTES) . '\'';
            $insertQry = 'INSERT INTO Users VALUES (' . $entry . ');';
            if (self::$Connection->query($insertQry)) {
                echo "Success<br>";
            } else {
                echo "Error registering user: " . self::$Connection->error . "<br>";
            }
            self::closeDatabasing();
        } else {
            echo "Warning: " . $data->Username . " already exists. Please specify a new username.<br>";
        }
    }
    public static function createPost($data, $CommandText, $CommandId) {
        $username = $_SESSION["username"];
        self::establishDatabasing();
        $entry = '"' . $username . '","' . filter_var($data, FILTER_SANITIZE_MAGIC_QUOTES) . '","'.filter_var($CommandText,FILTER_SANITIZE_MAGIC_QUOTES).'",'.$CommandId.', now()';
        $insertQry = 'INSERT INTO Posts VALUES (' . $entry . ');';
        if (self::$Connection->query($insertQry)) {
            echo "Success<br>";
        } else {
            echo "Error creating row: " . self::$Connection->error . "<br>";
        }
        self::closeDatabasing();
    }
    public static function loadAllPosts() {
        self::establishDatabasing();
        $loadQry = 'SELECT * FROM Posts WHERE UserId = "'.self::getUsername().'";';
        $qryResult = self::$Connection->query($loadQry);
        $first = true;
        echo "[";
        while ($row = $qryResult->fetch_assoc()) {
            if ($first != true) {
                echo ',';
            }
            echo "{\"UserId\":\"" . filter_var($row["UserId"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"PostText\":\"" . filter_var($row["PostText"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"CommandText\":\"" . filter_var($row["CommandText"], FILTER_SANITIZE_SPECIAL_CHARS) .
                "\",\"CommandInt\":\"" . $row["CommandInt"] .
                "\",\"PostTimeStamp\":\"" . $row["PostTimeStamp"] . "\"}";
            $first = false;
        }
        echo "]";
        self::closeDatabasing();
    }
    public static function emailPost($data) {
        // TODO move the information below to a more secure place

        // Ensure that the server (from) gmail email address has 'allow less secure apps' enabled
        // Goto php.ini
        // extension=php_openssl.dll
        // SMTP=smtp.gmail.com
        // smtp_port=587
        // sendmail_from = ss.smtp.mailbox@gmail.com
        // sendmail_path = "\"C:\xampp\sendmail\sendmail.exe\" -t"

        // Edit C:\xampp\sendmail\sendmail.ini to be as follows:
        //[sendmail]
        //smtp_server=smtp.gmail.com
        //smtp_port=587
        //error_logfile=error.log
        //debug_logfile=debug.log
        //auth_username=ss.smtp.mailbox@gmail.com
        //auth_password=Test123!
        //force_sender=ss.smtp.mailbox@gmail.com

        mail($data->EmailAddress, "Chirp Email Validation Code", $data->Message);
        echo "Success sending message to: " . $data->EmailAddress;
    }

    // App specific
    protected static $AppConnection;
    public static function establishAppDatabasing() {
        $DatabaseNameStr = self::getUsername();
        self::$AppConnection = new mysqli("localhost", "root", "password");
        if (self::$AppConnection->connect_error) {
            die("Connection failed: " . self::$AppConnection->connect_error . "<br>");
        }
        $sql = "CREATE DATABASE IF NOT EXISTS ".$DatabaseNameStr;
        if (self::$AppConnection->query($sql) !== TRUE) {
            echo "Error creating database: " . self::$AppConnection->error . "<br>";
        }
        self::$AppConnection = new mysqli("localhost", "root", "password", $DatabaseNameStr);
    }
    public static function closeAppDatabasing() {
        self::$AppConnection->close();
    }
    public static function setupAppDatabase() {
        self::createAppTables();
    }
    public static function createAppTables() {
        self::establishAppDatabasing();
        foreach (array("Automation" => null, "Batch" => array("AutomationInt"), "Command" => array("BatchInt", "Path", "Command"), "Report" => array("CommandInt")) as $Key => $Value) {
            if (!self::$AppConnection->query("select 1 from " . $Key . " LIMIT 1")) {
                $sql = "CREATE TABLE " . $Key . " (Id int NOT NULL AUTO_INCREMENT, Name VARCHAR(50), Status TEXT(65535), Mode TEXT(65535), Enabled VARCHAR(50)";
                if (is_array($Value)) {
                    foreach ($Value as $Attribute) {
                        $sql .= "," . $Attribute . (strpos($Attribute, "Int") !== false ? " int" : " TEXT(65535)");
                    }
                }
                $sql .= ", PRIMARY KEY(Id))";
                if (self::$AppConnection->query($sql)) {
                    echo "Success creating " . $Key . ":" . json_encode($Value) . " table<br>";
                } else {
                    echo "Error creating ".$Key." table: " . self::$AppConnection->error . "<br>";
                }
            } else {
                echo $Key;
            }
        }
        $Key = "Config";
        if (!self::$AppConnection->query("select 1 from " . $Key . " LIMIT 1")) {
            $sql = "CREATE TABLE " . $Key . " (Id int NOT NULL AUTO_INCREMENT, AutomationId int, BatchId int";
            $sql .= ", PRIMARY KEY(Id))";
            if (self::$AppConnection->query($sql)) {
                echo "Success creating " . $Key . " table<br>";
            } else {
                echo "Error creating " . $Key . " table: " . self::$AppConnection->error . "<br>";
            }
        } else {
            echo $Key;
        }
        self::closeAppDatabasing();
    }
    public static function readFields($TableNameStr,$ClauseStr = '') {
      self::establishAppDatabasing();
      $loadQry = 'SELECT * FROM '.$TableNameStr.' '.$ClauseStr;
        $qryResult = self::$AppConnection->query($loadQry);
        $ReturnArr = array();
        while ($row = $qryResult->fetch_assoc()) {
            $ReturnArr[] = $row;
        }
        echo json_encode($ReturnArr);
      self::closeAppDatabasing();
    }
    public static function multiQuery($QueryArrStr) {
        self::establishAppDatabasing();
        $QueryArr = json_decode($QueryArrStr);
        foreach ($QueryArr as $QueryStr) {
            if (!self::$AppConnection->query($QueryStr)) {
                echo "Error updating table: " . self::$AppConnection->error . "<br>";
            }
        }
        echo "Done with multiquery";
        self::closeAppDatabasing();
    }
    public static function updateCommand($CommandStr, $CommandId) {
        self::establishAppDatabasing();
        $FilteredCommandStr = filter_var($CommandStr, FILTER_SANITIZE_MAGIC_QUOTES);
        $QueryStr = 'UPDATE Command SET Command ="'.$FilteredCommandStr.'" WHERE Id = '.$CommandId;
        if (!self::$AppConnection->query($QueryStr)) {
            echo "Error updating table: " . self::$AppConnection->error . "<br>";
        }
        echo "Done with updateCommand";
        self::closeAppDatabasing();
    }
}
?>