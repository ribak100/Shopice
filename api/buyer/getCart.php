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
        echo json_encode(array('success' => 0, 'message' => 'Buyer ID is required!'));
        die();
    }

    echo json_encode(array('success' => 1, 'Cart Products' => $cart->get_cart_per_buyer($cart->buyer_id)));

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


