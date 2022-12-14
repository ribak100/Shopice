<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/Buyer.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if($buyer->validate_params($_POST['name'])){
        $buyer->name = $_POST['name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Name is required!'));
        die();
    }

    if($buyer->validate_params($_POST['email'])){
        $buyer->email = $_POST['email'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Email is required!'));
        die();
    }

    if($buyer->validate_params($_POST['password'])){
        $buyer->password = $_POST['password'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Password is required!'));
        die();
    }

    $buyer_images_folder = '../../assets/buyer_images/';

    if (!is_dir($buyer_images_folder)){
        mkdir($buyer_images_folder);
    }

    if(isset($_FILES['image'])){
        $file_name = $_FILES['image']['name'];
        $file_tmp = $_FILES['image']['tmp_name'];
        $extension = end(explode('.', $file_name));

        $new_file_name = $buyer->email . "_profile" . "." . $extension;

        move_uploaded_file($file_tmp,  $buyer_images_folder . "/" . $new_file_name);

        $buyer->image = 'buyer_images/' . $new_file_name;
    }

    if($buyer->validate_params($_POST['address'])){
        $buyer->address = $_POST['address'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Address is required!'));
        die();
    }
    
    if ($buyer->check_unique_email()){
        if ($id = $buyer->register_buyer()){
            http_response_code(200);
            echo json_encode(array('success' => 1, 'message' => 'buyer registered'));
        }
        else{
            http_response_code(500);
            echo json_encode(array('success' => 0, 'message' => 'Internal server error!'));
        }
    }
    else{
        http_response_code(401);
        echo json_encode(array('success' => 0, 'message' => 'User already exist!'));
    }

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}