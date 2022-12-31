<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/buying.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($buy->validate_params($_GET['buyer_id'])){
        $buy->buyer_id = $_GET['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'buyer ID is required!'));
        die();
    }

    if($buy->validate_params($_GET['buyer_name'])){
        $buy->buyer_name = $_GET['buyer_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller Name is required!'));
        die();
    }
    

    echo json_encode(array('success' => 1, 'paid' => $buy->get_delivered_orders_buyer($buy->buyer_id, $buy->buyer_name)));

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


