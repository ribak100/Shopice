<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Buyer.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($buyer->validate_params($_GET['id'])){
        $buyer->id = $_GET['id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer is required!'));
        die();
    }


    if($buyer->validate_params($_GET['name'])){
        $buyer->name = $_GET['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }

    if($buyer->validate_params($_GET['oldPassword'])){
        $buyer->oldPassword = $_GET['oldPassword'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'old Passwrod is required!'));
        die();
    }

    if($buyer->validate_params($_GET['newPassword'])){
        $buyer->newPassword = $_GET['newPassword'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'New Passwrod is required!'));
        die();
    }


    if($buyer->change_password($buyer->id, $buyer->name, $buyer->newPassword, $buyer->oldPassword) == true){
        echo "Success";
    }
    else{
        echo "Old Password Incorrect";
    }
    

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}