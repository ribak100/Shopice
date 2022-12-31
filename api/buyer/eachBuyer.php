<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: GET');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Buyer.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    if($buyer->validate_params($_GET['id'])){
        $buyer->id = $_GET['id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer ID is required!'));
        die();
    }

    if($buyer->validate_params($_GET['name'])){
        $buyer->name = $_GET['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer Name is required!'));
        die();
    }
    
echo json_encode(array('success' => 1, 'buyers' => $buyer->each_buyers($buyer->id, $buyer->name)));

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}

