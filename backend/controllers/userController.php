<?php
include_once(__DIR__ . '/../db/conexion.php');

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

$sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(['success' => true, 'message' => 'Login correcto']);
} else {
    echo json_encode(['success' => false, 'message' => 'Credenciales inválidas']);
}
?>
