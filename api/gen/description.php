<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Seller.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($seller->validate_params($_GET['id'])){
        $seller->id = $_GET['id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller ID is required!'));
        die();
    }

    echo json_encode(array('success' => 1, 'Description' => $seller->seller_description($seller->id)));

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}


