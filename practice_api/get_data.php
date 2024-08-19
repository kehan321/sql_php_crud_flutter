<?php

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Define and execute query
$sql = "SELECT id, name, age FROM mymy";
if ($result = $conn->query($sql)) {
    // Check if there are results
    if ($result->num_rows > 0) {
        // Output data of each row
        while($row = $result->fetch_assoc()) {
            echo "<br> id: ". htmlspecialchars($row["id"]). " - Name: ". htmlspecialchars($row["name"]). " " . htmlspecialchars($row["age"]) . "<br>";
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
