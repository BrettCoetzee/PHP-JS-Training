<?php
session_start();
$target_dir = "";
$returnValue = "";
$specified = basename($_FILES["fileToUpload"]["name"]);
$target_file = $target_dir . $_SESSION["username"] . '.png';
echo $target_file;
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        $returnValue = $returnValue . "File is an image - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        $returnValue = $returnValue .  "File is not an image.";
        $uploadOk = 0;
    }
}

if(file_exists($target_file)) {
    chmod($target_file,0755); // Change the file permissions if allowed
    unlink($target_file); // Delete the file
}

if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
    $returnValue = $returnValue .  "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = 0;
}

if ($uploadOk == 0) {
    $returnValue = $returnValue . "Sorry, your file was not uploaded.";
} else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        $returnValue = $returnValue . "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
    } else {
        $returnValue = $returnValue . "Sorry, there was an error uploading your file.";
    }
}
//echo $returnValue;
header('Location: http://localhost/projects/dev/config.html');
?>