<?php


<?php
header("Access-Control-Allow-Origin: *"); // Allows all domains
header("Access-Control-Allow-Methods: POST, GET, OPTIONS"); // Allows specific methods
header("Access-Control-Allow-Headers: Content-Type"); // Allows specific headers

// Your existing code here
?>

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "mysql";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>



<?php
include 'config.php';

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    $name = $data['name'];
    $age = $data['age'];

    $sql = "INSERT INTO mydata (name, age) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $name, $age);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Record added successfully."]);
    } else {
        echo json_encode(["status" => "error", "message" => $stmt->error]);
    }

    $stmt->close();
}

$conn->close();
?>



<?php
include 'config.php';

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];

    $sql = "DELETE FROM mydata WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Record deleted successfully."]);
    } else {
        echo json_encode(["status" => "error", "message" => $stmt->error]);
    }

    $stmt->close();
}

$conn->close();
?>



<?php
include 'config.php';

header('Content-Type: application/json');

$sql = "SELECT * FROM mydata";
$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);

$conn->close();
?>
