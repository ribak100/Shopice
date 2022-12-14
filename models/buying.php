<?php

$ds = DIRECTORY_SEPARATOR;
$base_dir = realpath(dirname(__FILE__). $ds . '..' ) . $ds;

require_once("{$base_dir}includes{$ds}Database.php"); //including database

class Buying {
    private $table = 'products';

    public $buyer_id;
    public $seller_id;
    public $seller_name;
    public $buyer_name
    public $image;
    public $price_per_kg;


    //constructor
    public function __construct()
    {
    }

    //validatig if params exist
    public function validate_params($value){
      
        return (!empty($value));
        
    }

    

}

$buy = new Buying();

