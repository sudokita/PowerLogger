<?php
include_once 'db_connector.php';
include_once 'http_responder.php';

	if (isset($_POST['time']) && isset($_POST['transition']) &&
		isset($_POST['state']) && isset($_POST['macaddress']))
	{
		$collection_mac = trim((string)$_POST['macaddress']);
		$state = trim((string)$_POST['state']);
		$transition = trim((string)$_POST['transition']);
		$time = trim((string)$_POST['time']);

		$conn = new DbConnector();
		$db = $conn->connection();

		$collection = $db->selectCollection($collection_mac);

		$log = array(
				'time' => $time,
				'state' => $state,
				'transition' => $transition
			);

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