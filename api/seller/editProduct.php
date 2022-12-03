<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Products.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    
    if($product->validate_params($_GET['seller_id'])){
        $product->seller_id = $_GET['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller is required!'));
        die();
    }

    if($product->validate_params($_GET['image'])){
        $product->image = $_GET['image'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'image is required!'));
        die();
    }

    if($product->validate_params($_GET['name'])){
        $product->name = $_GET['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }

    if($product->validate_params($_GET['price_per_kg'])){
        $product->price_per_kg = $_GET['price_per_kg'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'price_per_kg is required!'));
        die();
    }

    if($product->validate_params($_GET['description'])){
        $product->description = $_GET['description'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'description is required!'));
        die();
    }


    $product->editProduct($product->seller_id, $product->image, $product->name, $product->price_per_kg, $product->description);
    echo "Success = 1";

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}