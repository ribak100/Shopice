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

    if($buy->validate_params($_GET['seller_name'])){
        $buy->seller_name = $_GET['seller_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller Name is required!'));
        die();
    }
    

    echo json_encode(array('success' => 1, 'delivered' => $buy->get_delivered_orders($buy->seller_id, $buy->seller_name)));

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


