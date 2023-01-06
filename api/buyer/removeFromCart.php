<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/cart.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($cart->validate_params($_GET['seller_id'])){
        $cart->seller_id = $_GET['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller is required!'));
        die();
    }

    if($cart->validate_params($_GET['image'])){
        $cart->image = $_GET['image'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'image is required!'));
        die();
    }


    if($cart->validate_params($_GET['buyer_id'])){
        $cart->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer_id is required!'));
        die();
    }



    $cart->buy($cart->seller_id, $cart->image, $cart->buyer_id);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}