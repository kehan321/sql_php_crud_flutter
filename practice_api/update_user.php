<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "mysqll";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = $_POST['id'];
$name = $_POST['name'];
$age = $_POST['age'];

$sql = "UPDATE mymy SET name=?, age=? WHERE id=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sii", $name, $age, $id);

if ($stmt->execute()) {
    echo "Data updated successfully.";
} else {
    echo "Error updating data: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
