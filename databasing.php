<?php
  include 'mysql.php';
  $ReturnStr = 'Unset';
  switch ($_POST['command']) {
    // Generic
    case "setup": $ReturnStr = MySqlClass::setupDatabase(); break;
    case "chirp": $ReturnStr = MySqlClass::createPost($_POST['data'],$_POST['commandValue'],$_POST['commandId']); break;
    case "load": $ReturnStr = MySqlClass::loadAllPosts(); break;
    case "register": $ReturnStr = MySqlClass::registerUser(json_decode($_POST['data'])); break;
    case "login": $ReturnStr = MySqlClass::authenticateUser(json_decode($_POST['data'])); break;
    case "logout": $ReturnStr = MySqlClass::unsetUsername(json_decode($_POST['data'])); break;
    case "user": $ReturnStr = MySqlClass::getUsername(); break;
    case "save": $ReturnStr = MySqlClass::saveInformation(json_decode($_POST['data'])); break;
    case "password": $ReturnStr = MySqlClass::savePassword(json_decode($_POST['data'])); break;
    case "loaduser": $ReturnStr = MySqlClass::loadUser(MySqlClass::getUsername()); break;
    case "email": $ReturnStr = MySqlClass::emailPost(json_decode($_POST['data'])); break;
    case "cookie": $ReturnStr = MySqlClass::cookieUser($_POST['data']); break;

    // App specific
    case "updateCommand": $ReturnStr = MySqlClass::updateCommand($_POST['data'], $_POST['id']); break;
    case "fields": $ReturnStr = MySqlClass::readFields($_POST['data'],$_POST['clause']); break;
    case "multiQuery": $ReturnStr = MySqlClass::multiQuery($_POST['data']); break;
    case "curl": $ReturnStr = CURL($_POST['url'], $_POST['data']); break;
  }
  die($ReturnStr);

function CURL($Url, $CommandStr, $request = 'GET') {
    $url = $Url . '?command='.rawurlencode($CommandStr); // Note this is bad practice, rather use params
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $request);
    $data = curl_exec($ch);
    if($data === FALSE) {
        return null;
    }
    curl_close($ch);
    return $data;
}
?>