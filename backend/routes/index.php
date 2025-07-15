<?php
$path = $_GET['endpoint'] ?? '';

switch ($path) {
    case 'login':
        include('../controllers/userController.php');
        break;
    default:
        echo json_encode(['error' => 'Ruta no encontrada']);
}
?>
