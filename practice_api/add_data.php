<?php
// Include the database configuration file
include 'config.php';

// Get the raw POST data
$data = json_decode(file_get_contents("php://input"), true);

// Debugging: Log received data
error_log(print_r($data, true));

// Check if data is valid
if (is_null($data) || !isset($data['name']) || !isset($data['age'])) {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => 'Invalid or missing data']);
    exit();
}

// Extract 'name' and 'age' from the received data
$name = $data['name'];
$age = $data['age'];

// Create a new MySQLi connection
$conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_DATABASE);

// Check connection
if ($conn->connect_error) {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed: ' . $conn->connect_error]);
    exit();
}

// Prepare an SQL statement to prevent SQL injection
$stmt = $conn->prepare("INSERT INTO mymy (name, age) VALUES (?, ?)");
$stmt->bind_param("si", $name, $age);

// Execute the query
if ($stmt->execute()) {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'success', 'message' => 'Data added successfully']);
} else {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => 'Failed to add data: ' . $stmt->error]);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>
