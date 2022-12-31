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
    public $quantity;
    public $payment;
    public $shipping;
    public $delivery;
    public $total_price;
    public $count;
    


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
        $this->total_price = trim(htmlspecialchars(strip_tags($this->total_price)));
    

        $sql = "INSERT INTO $this->table (buyer_id, seller_id, seller_name, buyer_name, image, price, product_name, total_price) VALUEs (
            '" .$database->escape_value($this->buyer_id). "',
            '" .$database->escape_value($this->seller_id). "',
            '" .$database->escape_value($this->seller_name). "',
            '" .$database->escape_value($this->buyer_name). "',
            '" .$database->escape_value($this->image). "',
            '" .$database->escape_value($this->price). "',
            '" .$database->escape_value($this->product_name). "',
            '" .$database->escape_value($this->total_price). "'
        )";

        $result = $database->query($sql);

        if($result){
            return true;
        }else{
            return false;
        }
    }


     //method to delete from buying
     public function deleteFromBuy($buyer_id, $image)
     {
         global $database;
 
         $sql = "DELETE FROM buying WHERE buyer_id = $buyer_id AND image = '$image' ";
 
         $database->query($sql);
 
     }

    //method to delete from buying at the initial stage in case the last order wasnt successful
     public function deleteInstanceFromBuy($buyer_id , $buyer_name)
     {
         global $database;
 
         $sql = "DELETE FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND payment IS NULL ";
 
         $database->query($sql);
 
     }

     //method to delete from cart after order is successful
     public function deleteFromCartAfterBuy($buyer_id , $buyer_name)
     {
         global $database;
 
         $sql = "DELETE FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND payment IS NULL ";
 
         $database->query($sql);
 
     }




     
     //method to Set Payment
     public function payment($seller_id, $buyer_id, $payment)
     {
         global $database;
         //$this->name = trim(htmlspecialchars(strip_tags($this->name)));
         //$this->price_per_kg = trim(htmlspecialchars(strip_tags($this->price_per_kg)));
         //$this->description = trim(htmlspecialchars(strip_tags($this->description)));
 
         $sql = "UPDATE buying SET payment = '$payment' WHERE seller_id = $seller_id AND  buyer_id = '$buyer_id'";
 
         $database->query($sql);
 
     }

     //method to Set Shipping
     public function shipping($seller_id, $image, $buyer_id, $shipping)
     {
         global $database;
         //$this->name = trim(htmlspecialchars(strip_tags($this->name)));
         //$this->price_per_kg = trim(htmlspecialchars(strip_tags($this->price_per_kg)));
        // $this->description = trim(htmlspecialchars(strip_tags($this->description)));
 
         $sql = "UPDATE buying SET shipping = '$shipping' WHERE seller_id = $seller_id AND image = '$image' AND  buyer_id = '$buyer_id'";
 
         $database->query($sql);
 
     }

     //method to Set Delivery
     public function delivery($seller_id, $image, $buyer_id, $delivery)
     {
         global $database;
         //$this->name = trim(htmlspecialchars(strip_tags($this->name)));
         //$this->price_per_kg = trim(htmlspecialchars(strip_tags($this->price_per_kg)));
         //$this->description = trim(htmlspecialchars(strip_tags($this->description)));
 
         $sql = "UPDATE buying SET delivery = '$delivery' WHERE seller_id = $seller_id AND image = '$image' AND  buyer_id = '$buyer_id'";
 
         $database->query($sql);
 
     }


     //method to get image in buying database
     public function get_image($seller_id, $buyer_id, $price, $product_name)
    {
        global $database;
        //$this->buyer_id = trim(htmlspecialchars(strip_tags($this->buyer_id)));

        $sql = "SELECT * FROM $this->table WHERE buyer_id = $buyer_id AND seller_id = $seller_id AND price = '$price' AND product_name = '$product_name'";

        $result = $database->query($sql);

        $returnImage = $database->fetch_row($result);
        return $returnImage['image'];


    }

    //method to update quantity
    public function quantity($seller_id, $image, $buyer_id, $quantity)
    {
        global $database;

        $sql = "UPDATE buying SET quantity = $quantity WHERE seller_id = $seller_id AND image = '$image' AND  buyer_id = '$buyer_id'";

        $database->query($sql);

    }

    
    //method to update total price
    public function total_price($seller_id, $image, $buyer_id, $total_price)
    {
        global $database;

        $sql = "UPDATE buying SET total_price = $total_price WHERE seller_id = $seller_id AND image = '$image' AND  buyer_id = '$buyer_id'";

         $database->query($sql);
    

    }


    //method to get Total Price
    public function price($buyer_name, $buyer_id)
    {
        global $database;

        $sql = "SELECT price FROM buying WHERE buyer_name = '$buyer_name' AND  buyer_id = $buyer_id AND payment IS NULL ";

        $result = $database->query($sql);

        return $database->fetch_array($result);

    }

    //method to get Total coubt
    public function count($buyer_name, $buyer_id)
    {
        global $database;

        $sql = "SELECT quantity FROM buying WHERE buyer_name = '$buyer_name' AND  buyer_id = $buyer_id AND payment IS NULL ";

        $result = $database->query($sql);

        return $database->fetch_array($result);

    }

    //method to get Total price
    public function get_total_price($buyer_name, $buyer_id)
    {
        global $database;

        $sql = "SELECT total_price FROM buying WHERE buyer_name = '$buyer_name' AND  buyer_id = $buyer_id AND payment IS NULL ";

        $result = $database->query($sql);

        return $database->fetch_array($result);

    }

    //method to get paid orders thats not shipped
    public function get_paid_orders($seller_id, $seller_name)
    {
        global $database;

        $sql = "SELECT * FROM buying WHERE seller_id = $seller_id AND seller_name = '$seller_name' AND shipping IS NULL AND payment = 'paid'";

        $result = $database->query($sql);

        
        return $database->fetch_array($result);


    }

    //method to get shipped orders thats not delivered
    public function get_shipped_orders($seller_id, $seller_name)
    {
        global $database;

        $sql = "SELECT * FROM buying WHERE seller_id = $seller_id AND seller_name = '$seller_name' AND payment = 'paid' AND shipping = 'shipped' AND delivery IS NULL ";

        $result = $database->query($sql);

        
        return $database->fetch_array($result);


    }

    //method to get completed orders
    public function get_delivered_orders($seller_id, $seller_name)
    {
        global $database;

        $sql = "SELECT * FROM buying WHERE seller_id = $seller_id AND seller_name = '$seller_name' AND delivery = 'delivered' AND payment = 'paid' AND shipping = 'shipped'";

        $result = $database->query($sql);

        
        return $database->fetch_array($result);


    }
    

     //method to get pending orders that payment is not complete
     public function get_pending_orders($buyer_id, $buyer_name)
     {
         global $database;
 
         $sql = "SELECT * FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND payment = 'pending'";
 
         $result = $database->query($sql);
 
         
         return $database->fetch_array($result);
 
 
     }

      //method to get paid orders pending shippment
    public function get_pending_shipment($buyer_id, $buyer_name)
    {
        global $database;

        $sql = "SELECT * FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND shipping IS NULL AND payment = 'paid'";

        $result = $database->query($sql);

        
        return $database->fetch_array($result);


    }

     //method to get shipped orders thats not delivered for buyers
     public function get_shipped_orders_buyer($buyer_id, $buyer_name)
     {
         global $database;
 
         $sql = "SELECT * FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND payment = 'paid' AND shipping = 'shipped' AND delivery IS NULL ";
 
         $result = $database->query($sql);
 
         
         return $database->fetch_array($result);
 
 
     }

     //method to get completed orders for buyers
    public function get_delivered_orders_buyer($buyer_id, $buyer_name)
    {
        global $database;

        $sql = "SELECT * FROM buying WHERE buyer_id = $buyer_id AND buyer_name = '$buyer_name' AND delivery = 'delivered' AND payment = 'paid' AND shipping = 'shipped'";

        $result = $database->query($sql);

        
        return $database->fetch_array($result);


    }


    

}

$buy = new Buying();

