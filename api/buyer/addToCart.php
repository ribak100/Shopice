<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Method: POST');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');

include_once '../../models/cart.php';


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if($cart->validate_params($_POST['buyer_id'])){
        $cart->buyer_id = $_POST['buyer_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer ID is required!'));
        die();
    }

    if($cart->validate_params($_POST['seller_id'])){
        $cart->seller_id = $_POST['seller_id'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller ID is required!'));
        die();
    }

    if($cart->validate_params($_POST['seller_name'])){
        $cart->seller_name = $_POST['seller_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Seller name is required!'));
        die();
    }

    if($cart->validate_params($_POST['buyer_name'])){
        $cart->buyer_name = $_POST['buyer_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Buyer name is required!'));
        die();
    }

    

    
    if($cart->validate_params($_POST['product_name'])){
        $cart->product_name = $_POST['product_name'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Ptoduct name is required!'));
        die();
    }
    

    // if(isset($_FILES['image'])){
    //     $file_name = $_FILES['image']['name'];
    //     $file_tmp = $_FILES['image']['tmp_name'];
    //     $extension = end(explode('.', $file_name));

    //     $new_file_name = $cart->buyer_name . "_profile_" . $cart->product_name . "." . $extension;

    //     move_uploaded_file($file_tmp,  $cart_images_folder . "/" . $new_file_name);

    //     $cart->image = 'cart_images/' . $new_file_name;
    // }

    $cart_images_folder = '../../assets/cart_images/' ;
    $product_images_folder = '../../assets/product_images/';

    if (!is_dir($cart_images_folder)){
        mkdir($cart_images_folder);
    }



    if($cart->validate_params($_POST['image'])){
        $source_file = '../../assets/' . $_POST['image']; 
        $extension = end(explode('.', $_POST['image']));
        $new_file_name = $cart->buyer_name . "_profile_" . $cart->product_name . "." . $extension;
        $destination = $cart_images_folder . $new_file_name;
        $cart->image = 'cart_images/' . $new_file_name;

        copy($source_file, $destination);
        if(is_file($destination)){
            print("\nDir Exist");
        }
        else{
            print("\ninvalid DIr");
        }
        // print("\nDestination" . $destination);
        // print("\nSource file" . $source_file);

    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Image is required!'));
        die();
    }


    if($cart->validate_params($_POST['price'])){
        $cart->price = $_POST['price'];
    }
    else{
        echo json_encode(array('success' => 0, 'message' => 'Price is required!'));
        die();
    }

     if ($cart->addToCart()){
        http_response_code(200);
        echo json_encode(array('success' => 1, 'message' => 'Product added to cart successfully'));
     }
     else{
         http_response_code(500);
         echo json_encode(array('success' => 0, 'message' => 'Internal server error!'));
        }
    

} else {
    die(header('HTTP/1.1 405 Request Method Not Allowed'));
}