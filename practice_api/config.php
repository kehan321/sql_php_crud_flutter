<?php
$servername = "localhost";
$username = "root";        // Update with your MySQL username
$password = "";            // Update with your MySQL password
$dbname = "mysqll";        // Update with your database name
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
    
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Define and execute query
$sql = "SELECT * FROM mymy"; // Fetch all columns from the mymy table
$result = $conn->query($sql);

if ($result) {
    // Check if there are results
    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            echo "<br>";
            foreach ($row as $column => $value) {
                echo htmlspecialchars($column) . ": " . htmlspecialchars($value) . "<br>";
            }
        }
    } else {
        echo "0 results";
    }
    // Free result set
    $result->free();
} else {
    // Query execution error
    echo "Error executing query: " . $conn->error;
}

// Close connection
$conn->close();
?>
