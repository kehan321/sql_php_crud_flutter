<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "mysqll";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = $_POST['id'] ?? '';

// Debugging output
echo "Received id: $id<br>";

if (!$id) {
    die("Invalid input");
}

$sql = "DELETE FROM mymy WHERE id = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    die("Prepare failed: " . $conn->error);
}

$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo "Data deleted successfully.";
} else {
    echo "Error deleting data: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
