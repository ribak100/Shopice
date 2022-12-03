<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Products.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($product->validate_params($_GET['interaction_count'])){
        $product->interaction_count = $_GET['interaction_count'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'interaction count is required!'));
        die();
    }

    if($product->validate_params($_GET['name'])){
        $product->name = $_GET['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'name is required!'));
        die();
    }

    if($product->validate_params($_GET['seller_id'])){
        $product->seller_id = $_GET['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller ID is required!'));
        die();
    }


    $product->interaction($product->interaction_count, $product->name, $product->seller_id);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}