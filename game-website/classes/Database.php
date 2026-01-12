<?php
class Database {
    private static $instance = null;
    private $mysqli;

    private function __construct() {
        require_once __DIR__ . '/../includes/config.php';
        $this->mysqli = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

        if ($this->mysqli->connect_error) {
            die("Connection failed: " . $this->mysqli->connect_error);
        }
    }

    public static function getInstance() {
        if (self::$instance == null) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->mysqli;
    }
}
?>