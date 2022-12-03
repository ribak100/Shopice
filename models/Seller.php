<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' ) . $ds;

require_once("{$base_dir}includes{$ds}Database.php"); //including database
require_once("{$base_dir}includes{$ds}Bcrypt.php"); //including Bcrypt

class Seller{
    private $table = 'sellers';

    public $id;
    public $name;
    public $email;
    public $password;
    public $image;
    public $address;
    public $description;
    public $rating;


    //constructor
    public function __construct(){}

    //validatig if params exist
    public function validate_params($value){
      
        return (!empty($value));
        
    }

    // to check for unique emsil
    public function check_unique_email(){
        global $database;

        $this->email = trim(htmlspecialchars(strip_tags($this->email)));

        $sql = "SELECT id FROM $this->table WHERE email = '" .$database->escape_value($this->email). "'";

        $result = $database->query($sql);
        $user_id = $database->fetch_row($result);

        return empty($user_id);
    }


    //saving new data in database
    public function register_seller(){
        global $database;

        $this->name = trim(htmlspecialchars(strip_tags($this->name)));
        $this->email = trim(htmlspecialchars(strip_tags($this->email)));
        $this->password = trim(htmlspecialchars(strip_tags($this->password)));
        $this->image = trim(htmlspecialchars(strip_tags($this->image)));
        $this->address = trim(htmlspecialchars(strip_tags($this->address)));
        $this->description = trim(htmlspecialchars(strip_tags($this->description)));

        $sql ="INSERT INTO $this->table (name, email, password, image, address, description) VALUES (
            '" .$database->escape_value($this->name). "',
            '" .$database->escape_value($this->email). "',
            '" .$database->escape_value(Bcrypt::hashPassword($this->password)). "',
            '" .$database->escape_value($this->image). "',
            '" .$database->escape_value($this->address). "',
            '" .$database->escape_value($this->description). "'
        )";

        $seller_saved = $database->query($sql);

        if($seller_saved){
            return true;
        }
        else{
            return false;
        }
    }



    //login function
    public function login(){
        global $database;

        $this->email = trim(htmlspecialchars(strip_tags($this->email)));
        $this->password = trim(htmlspecialchars(strip_tags($this->password)));

        $sql = "SELECT * FROM $this->table WHERE email = '" .$database->escape_value($this->email). "'";
        
        $result = $database->query($sql);
        $seller = $database->fetch_row($result);

        if(empty($seller)) {
            return "Seller doesn't exist";
        }
        else{
            if(Bcrypt::checkPassword($this->password, $seller['password'])){
                unset($seller['password']);

                return $seller;
            }
            else{
                return "Password doesnt match";
            }
        }

    }

    //fucntion to return list of sellers
    public function all_sellers(){
        global $database;

        $sql = "SELECT id, name, image, address, description FROM $this->table";

        $result = $database->query($sql);

        return $database->fetch_array($result);
    }
    
    public function seller_description($sellerId){
        global $database;
        $this->id = trim(htmlspecialchars(strip_tags($this->id)));

        $sql = "SELECT description FROM sellers WHERE id = $sellerId";

        echo json_encode($database->query($sql));
    }

}

$seller = new Seller();