<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' ) . $ds;

require_once("{$base_dir}includes{$ds}Database.php"); //including database

class Cart {
    private $table = 'cart';

    public $buyer_id;
    public $seller_id;
    public $seller_name;
    public $buyer_name;
    public $image;
    public $price;
    public $product_name;


    //constructor
    public function __construct()
    {
    }

    //validatig if params exist
    public function validate_params($value){
      
        return (!empty($value));
        
    }


    //method to add to cart
    public function addToCart()
    {
        global $database;

        $this->buyer_id = trim(htmlspecialchars(strip_tags($this->buyer_id)));
        $this->seller_id = trim(htmlspecialchars(strip_tags($this->seller_id)));
        $this->seller_name = trim(htmlspecialchars(strip_tags($this->seller_name)));
        $this->buyer_name = trim(htmlspecialchars(strip_tags($this->buyer_name)));
        $this->image = trim(htmlspecialchars(strip_tags($this->image)));
        $this->price = trim(htmlspecialchars(strip_tags($this->price)));
        $this->product_name = trim(htmlspecialchars(strip_tags($this->product_name)));

        $sql = "INSERT INTO $this->table (buyer_id, seller_id, seller_name, buyer_name, image, price, product_name) VALUEs (
            '" .$database->escape_value($this->buyer_id). "',
            '" .$database->escape_value($this->seller_id). "',
            '" .$database->escape_value($this->seller_name). "',
            '" .$database->escape_value($this->buyer_name). "',
            '" .$database->escape_value($this->image). "',
            '" .$database->escape_value($this->price). "',
            '" .$database->escape_value($this->product_name). "'
        )";

        $result = $database->query($sql);

        if($result){
            return true;
        }else{
            return false;
        }
    }

    //method to return list of product int the cart
    public function get_cart_per_buyer($buyerId)
    {
        global $database;
        $this->buyer_id = trim(htmlspecialchars(strip_tags($this->buyer_id)));

        $sql = "SELECT * FROM $this->table WHERE buyer_id =  $buyerId";

        $result = $database->query($sql);

        return $database->fetch_array($result);

    }


}

$cart = new Cart();

