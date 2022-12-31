<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/buying.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($buy->validate_params($_GET['seller_id'])){
        $buy->seller_id = $_GET['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller is required!'));
        die();
    }

    if($buy->validate_params($_GET['buyer_id'])){
        $buy->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer_id is required!'));
        die();
    }

    if($buy->validate_params($_GET['payment'])){
        $buy->payment = $_GET['payment'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'payment is required!'));
        die();
    }


    $buy->payment($buy->seller_id, $buy->buyer_id, $buy->payment);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}