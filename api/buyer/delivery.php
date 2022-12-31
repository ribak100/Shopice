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

    if($buy->validate_params($_GET['image'])){
        $buy->image = $_GET['image'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'image is required!'));
        die();
    }


    if($buy->validate_params($_GET['buyer_id'])){
        $buy->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer_id is required!'));
        die();
    }

    if($buy->validate_params($_GET['delivery'])){
        $buy->delivery = $_GET['delivery'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'delivery is required!'));
        die();
    }


    $buy->delivery($buy->seller_id, $buy->image, $buy->buyer_id, $buy->delivery);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}