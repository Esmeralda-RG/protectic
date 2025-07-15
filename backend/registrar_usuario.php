<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
echo "Script iniciado<br>";

include("db/conexion.php");

echo "Conexión cargada<br>";

$data = json_decode(file_get_contents("php://input"));
echo "Datos recibidos<br>";

if (!$data) {
    die("No se recibió JSON");
}

$nombre = $data->nombre ?? '';
$email = $data->email ?? '';
$password = $data->password ?? '';

if (!$nombre || !$email || !$password) {
    die("Faltan campos obligatorios");
}

$hash = password_hash($password, PASSWORD_DEFAULT);
$sql = "INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $nombre, $email, $hash);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Usuario registrado correctamente"]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . $stmt->error]);
}
?>
