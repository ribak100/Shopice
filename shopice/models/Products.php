<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' ) . $ds;

require_once("{$base_dir}includes{$ds}Database.php"); //including database

class Product {
    private $table = 'products';

    public $id;
    public $seller_id;
    public $name;
    public $image;
    public $price_per_kg;
    public $description;
    public $interaction_count;

    //constructor
    public function __construct()
    {
    }

    //validatig if params exist
    public function validate_params($value){
      
        return (!empty($value));
        
    }


    public function add_product(){
        global $database;

        $this->seller_id = trim(htmlspecialchars(strip_tags($this->seller_id)));
        $this->name = trim(htmlspecialchars(strip_tags($this->name)));
        $this->image = trim(htmlspecialchars(strip_tags($this->image)));
        $this->price_per_kg = trim(htmlspecialchars(strip_tags($this->price_per_kg)));
        $this->description = trim(htmlspecialchars(strip_tags($this->description)));
        //$this->interaction_count = trim(htmlspecialchars(strip_tags($this->interaction_count)));

        $sql = "INSERT INTO $this->table (seller_id, name, image, price_per_kg, description) VALUEs (
            '" .$database->escape_value($this->seller_id). "',
            '" .$database->escape_value($this->name). "',
            '" .$database->escape_value($this->image). "',
            '" .$database->escape_value($this->price_per_kg). "',
            '" .$database->escape_value($this->description). "'
        )";

        $result = $database->query($sql);

        if($result){
            return true;
        }else{
            return false;
        }

    }

    //method to return list of profucts
    public function get_product_per_seller()
    {
        global $database;
        $this->seller_id = trim(htmlspecialchars(strip_tags($this->seller_id)));

        $sql = "SELECT * FROM $this->table WHERE seller_id = '" .$database->escape_value($this->seller_id). "' ";

        $result = $database->query($sql);

        return $database->fetch_array($result);

    }

     //method to increase interaction
     public function interaction($intern_count, $product_name, $seller_id_product)
     {
         global $database;
         $this->interaction_count = trim(htmlspecialchars(strip_tags($this->interaction_count)));
         $this->seller_id = trim(htmlspecialchars(strip_tags($this->seller_id)));
 
         $sql = "UPDATE products SET interaction_count = $intern_count WHERE seller_id = $seller_id_product AND name = '$product_name' ";
 
         $database->query($sql);
 
     }

     //method to edit product details
     public function editProduct($seller_id, $image, $newName, $newPrice_per_kg, $newDescription)
     {
         global $database;
         //$this->name = trim(htmlspecialchars(strip_tags($this->name)));
         $this->price_per_kg = trim(htmlspecialchars(strip_tags($this->price_per_kg)));
         $this->description = trim(htmlspecialchars(strip_tags($this->description)));
 
         $sql = "UPDATE products SET name = '$newName', price_per_kg = $newPrice_per_kg, description = '$newDescription' WHERE seller_id = $seller_id AND image = '$image' ";
 
         $database->query($sql);
 
     }
 
       //method to edit product details
       public function deleteProduct($seller_id, $image)
       {
           global $database;
   
           $sql = "DELETE FROM products WHERE seller_id = $seller_id AND image = '$image' ";
   
           $database->query($sql);
   
       }
   

}

$product = new Product();

