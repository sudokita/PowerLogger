<?php

include_once 'db_connector.php';
include_once 'http_responder.php';

	if (isset($_POST['time']) && isset($_POST['transition']) &&
		isset($_POST['state']) && isset($_POST['macaddress']))
	{
		$collection_mac = trim((string)$_POST['macaddress']);
		$macCollection = str_replace(":", "", $collection_mac);
		$state = trim((string)$_POST['state']);
		$transition = trim((string)$_POST['transition']);
		$time = trim((string)$_POST['time']);
		$mem = $_POST['mem_stats'];

		$conn = new DbConnector();
		$db = $conn->connection();

		$log = array(
				'time' => $time,
				'state' => $state,
				'transition' => $transition,
				'mem_stats' => $mem
			);

		$collection = $db->selectCollection($macCollection);

		$success = $collection->insert($log);
		$message = "Log was not inserted.";

		if ($success == true){
			$message = "Log was successfully inserted.";
		}

		$responder = new HttpResponder();

		$result = array();
		$result['result'] = array(
				'code' => '200',
				'message' => $message
			);

		$responder->sendResponse(200, json_encode($result));
	}

?>