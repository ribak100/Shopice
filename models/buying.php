<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' ) . $ds;

require_once("{$base_dir}includes{$ds}Database.php"); //including database

class Buying {
    private $table = 'buying';

    public $buyer_id;
    public $seller_id;
    public $seller_name;
    public $buyer_name;
    public $price;
    public $product_name;
    public $image;
    public $payment;
    public $shipping;
    public $delivery;
    


    //constructor
    public function __construct()
    {
    }

    //validatig if params exist
    public function validate_params($value){
      
        return (!empty($value));
        
    }


    //method to add to buying
    public function addToBuy()
    {
        global $database;

        $this->buyer_id = trim(htmlspecialchars(strip_tags($this->buyer_id)));
        $this->seller_id = trim(htmlspecialchars(strip_tags($this->seller_id)));
        $this->seller_name = trim(htmlspecialchars(strip_tags($this->seller_name)));
        $this->buyer_name = trim(htmlspecialchars(strip_tags($this->buyer_name)));
        $this->price = trim(htmlspecialchars(strip_tags($this->price)));
        $this->product_name = trim(htmlspecialchars(strip_tags($this->product_name)));
        $this->image = trim(htmlspecialchars(strip_tags($this->image)));

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


    

}

$buy = new Buying();

