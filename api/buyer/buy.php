<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/buying.php';


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if($buy->validate_params($_POST['buyer_id'])){
        $buy->buyer_id = $_POST['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer ID is required!'));
        die();
    }

    if($buy->validate_params($_POST['seller_id'])){
        $buy->seller_id = $_POST['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller ID is required!'));
        die();
    }

    if($buy->validate_params($_POST['seller_name'])){
        $buy->seller_name = $_POST['seller_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller name is required!'));
        die();
    }

    if($buy->validate_params($_POST['buyer_name'])){
        $buy->buyer_name = $_POST['buyer_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer name is required!'));
        die();
    }

    

    
    if($buy->validate_params($_POST['product_name'])){
        $buy->product_name = $_POST['product_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Ptoduct name is required!'));
        die();
    }
    

    $buying_images_folder = '../../assets/buying_images/' ;
    //$cart_images_folder = '../../assets/cart_images/' ;

    if (!is_dir($buying_images_folder)){
        mkdir($buying_images_folder);
    }



    if($buy->validate_params($_POST['image'])){
        $source_file = '../../assets/' . $_POST['image']; 
        $extension = end(explode('.', $_POST['image']));
        $new_file_name = $buy->buyer_name . "_buying_" . $buy->product_name . "." . $extension;
        $destination = $buying_images_folder . $new_file_name;
        $buy->image = 'buying_images/' . $new_file_name;

        copy($source_file, $destination);
        if(is_file($destination)){
            print("\nDir Exist");
        }
        else{
            print("\ninvalid DIr");
        }
       

    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Image is required!'));
        die();
    }


    if($buy->validate_params($_POST['price'])){
        $buy->price = $_POST['price'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Price is required!'));
        die();
    }

    if($buy->validate_params($_POST['total_price'])){
        $buy->total_price = $_POST['total_price'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'total_price is required!'));
        die();
    }

     if ($buy->addToBuy()){
        http_response_code(200);
        echo json_encode(array('success' => 1, 'message' => 'Product added to buying successfully'));
     }
     else{
         http_response_code(500);
         echo json_encode(array('success' => 0, 'message' => 'Internal server error!'));
        }
    

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}