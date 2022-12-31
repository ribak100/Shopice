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
        echo json_encode(array('success' => 0, 'message' => 'Seller ID is required!'));
        die();
    }

    if($buy->validate_params($_GET['buyer_id'])){
        $buy->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer ID is required!'));
        die();
    }

    if($buy->validate_params($_GET['price'])){
        $buy->price = $_GET['price'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'price is required!'));
        die();
    }

    if($buy->validate_params($_GET['product_name'])){
        $buy->product_name = $_GET['product_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'product_name is required!'));
        die();
    }

    echo $buy->get_image($buy->seller_id, $buy->buyer_id, $buy->price, $buy->product_name);

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


