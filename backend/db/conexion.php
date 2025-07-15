<?php
$host = 'mysql.hostinger.com';
$db = 'u422802886_protectic';   
$user = 'u422802886_protectic2025'; 
$pass = 'Protectic2025';        

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}
?>
