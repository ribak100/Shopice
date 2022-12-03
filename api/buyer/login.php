<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Buyer.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if($buyer->validate_params($_POST['email'])){
        $buyer->email = $_POST['email'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Email is required!'));
        die();
    }

    if($buyer->validate_params($_POST['password'])){
        $buyer->password = $_POST['password'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Password is required!'));
        die();
    }

    $b = $buyer->login();
    if(gettype($b) === 'array'){
        http_response_code(200);
        echo json_encode(array('success' => 1, 'message' => 'Login Successful', 'buyer' => $b));
    }
    else{
        http_response_code(402);
        echo json_encode(array('success' => 0, 'message' => $b));
    }
}
else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}