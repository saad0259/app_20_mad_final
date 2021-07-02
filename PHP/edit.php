<?php


include 'connect.php';

$id=$_POST['id'];
$fname=$_POST['fname'];
$phone=$_POST['phone'];
$address=$_POST['address'];
$email=$_POST['email'];


 $conn-> query("UPDATE users SET fname='".$fname."',phone='".$phone."',address='".$address."',email='".$email."' WHERE id='".$id."'");


?>
