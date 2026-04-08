<?php
require 'db.php';

// 1. Get Token
$headers = null;
if (isset($_SERVER['Authorization'])) $headers = trim($_SERVER["Authorization"]);
else if (isset($_SERVER['HTTP_AUTHORIZATION'])) $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
elseif (function_exists('apache_request_headers')) {
    $reqHeaders = apache_request_headers();
    $reqHeaders = array_combine(array_map('ucwords', array_keys($reqHeaders)), array_values($reqHeaders));
    if (isset($reqHeaders['Authorization'])) $headers = trim($reqHeaders['Authorization']);
}

$token = null;
if (!empty($headers) && preg_match('/Bearer\s(\S+)/', $headers, $matches)) $token = $matches[1];

if (!$token) { echo json_encode(["success" => false, "message" => "Unauthorized"]); exit(); }

$stmt = $pdo->prepare("SELECT id FROM users WHERE api_token = ?");
$stmt->execute([$token]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) { echo json_encode(["success" => false, "message" => "Invalid token"]); exit(); }

// 2. Process Data
$data = json_decode(file_get_contents("php://input"), true);
$firstname = $data['firstname'];
$lastname = $data['lastname'];
$phone = $data['phone'];
$street_address = $data['address'];
$city = $data['city'] ?? 'Nairobi'; // Defaulting to Nairobi if not provided

try {
    $pdo->beginTransaction();

    // Update User
    $updateUser = $pdo->prepare("UPDATE users SET firstname = ?, lastname = ?, phone = ? WHERE id = ?");
    $updateUser->execute([$firstname, $lastname, $phone, $user['id']]);

    // Update or Insert Address
    $checkAddress = $pdo->prepare("SELECT id FROM shipping_addresses WHERE user_id = ?");
    $checkAddress->execute([$user['id']]);
    
    if ($checkAddress->rowCount() > 0) {
        $updateAddr = $pdo->prepare("UPDATE shipping_addresses SET street_address = ?, city = ? WHERE user_id = ?");
        $updateAddr->execute([$street_address, $city, $user['id']]);
    } else {
        $insertAddr = $pdo->prepare("INSERT INTO shipping_addresses (user_id, street_address, city, is_default) VALUES (?, ?, ?, 1)");
        $insertAddr->execute([$user['id'], $street_address, $city]);
    }

    $pdo->commit();
    echo json_encode(["success" => true, "message" => "Profile updated successfully"]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode(["success" => false, "message" => "Update failed: " . $e->getMessage()]);
}
?>