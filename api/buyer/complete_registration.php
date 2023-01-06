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
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }

    if($buyer->validate_params($_GET['name'])){
        $buyer->name = $_GET['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }

    if($buyer->validate_params($_GET['email'])){
        $buyer->email = $_GET['email'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }


    if($buyer->validate_params($_GET['address'])){
        $buyer->address = $_GET['address'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Address is required!'));
        die();
    }


    if($buyer->validate_params($_GET['phone_number'])){
        $buyer->phone_number = $_GET['phone_number'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Phone number is required!'));
        die();
    }

    if($buyer->validate_params($_GET['country'])){
        $buyer->country = $_GET['country'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Country is required!'));
        die();
    }

    if($buyer->validate_params($_GET['nationality'])){
        $buyer->nationality = $_GET['nationality'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'nationality is required!'));
        die();
    }

    if($buyer->validate_params($_GET['postal_code'])){
        $buyer->postal_code = $_GET['postal_code'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'postal_code is required!'));
        die();
    }

    if($buyer->validate_params($_GET['shipping_address'])){
        $buyer->shipping_address = $_GET['shipping_address'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Shipping address is required!'));
        die();
    }


    
    
        if (http_response_code(200)){
            $buyer->update_buyer($buyer->id , $buyer->email ,$buyer->name, $buyer->address, $buyer->phone_number, $buyer->country, $buyer->nationality, $buyer->postal_code, $buyer->shipping_address);
            echo json_encode(array('success' => 1, 'message' => 'buyer Updated'));
        }
        else{
            http_response_code(500);
            echo json_encode(array('success' => 0, 'message' => 'Internal server error!'));
        }
   

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}