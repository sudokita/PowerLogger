<?php

	class DbConnector {
		
		var $client;

		public function __construct() {
			$this->client = new MongoClient("mongodb://localhost");
		}
		
		public function connection() {
			// $this->a = new MongoClient("mongodb://" . $this->server . 
			// $this->port, array("username"=>$this->username, "password"=>$this->password));
			$db = $this->client->powerlogger;
			return $db;
		}

		public function __destruct() {
			unset($this->client);
		}

	};

?>