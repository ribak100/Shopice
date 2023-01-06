<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/cart.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') { 
    
    if($cart->validate_params($_GET['buyer_id'])){
        $cart->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer is required!'));
        die();
    }

    if($cart->validate_params($_GET['buyer_name'])){
        $cart->buyer_name = $_GET['buyer_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer_name is required!'));
        die();
    }

    $cart->deleteBuy($cart->buyer_id, $cart->buyer_name);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


