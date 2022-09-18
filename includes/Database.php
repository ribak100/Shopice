<?php

define('HOST', 'localhost');
define('USER_NAME', 'root');
define('PASSWORD', '');
define('DB_NAME', 'shopice');

//class db
class Database{
    private $connection;

    //constructior
    public function __construct(){
        $this->open_db_connection();
    }

    //creating connectinon
    public function open_db_connection(){
        $this->connection = mysqli_connect(HOST, USER_NAME, PASSWORD, DB_NAME);

        if(mysqli_connect_error()){
            die('Connection Error : '. mysqli_connect_error());
        }


    }

    //Executing SQL Query
    public function query($sql){
        $result = $this->connection->query($sql);

        if(!$result){
            die('Query fails : '. $sql);
        }

        return $result;
    }

    //fetching list of data from sql qurey
    public function fetch_array($result){
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $result_array[] = $row;
            }

            return $result_array;
        }
    }

    //fetching a single data from sql query
    public function fetch_row($result){
        if ($result->num_rows >0){
            return $result->fetch_assoc();
        }
    }

    //check proper format of data
    public function escape_value($value){
        return $this->connection->real_escape_string($value);
    }

    //close the connection
    public function close_connection(){
        $this->connection->close();
    }


}


$database = new Database();