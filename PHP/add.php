<?php


include 'connect.php';

$fname=$_POST['fname'];

$phone=$_POST['phone'];
$address=$_POST['address'];

$email=$_POST['email'];


     $conn-> query("INSERT INTO users(fname,phone,address,email)VALUES('".$fname."','".$phone."','".$address."','".$email."')");

?>
