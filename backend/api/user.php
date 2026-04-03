<?php
require 'db.php';

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

// 1. Get User
$stmt = $pdo->prepare("SELECT id, firstname, lastname, email, phone FROM users WHERE api_token = ?");
$stmt->execute([$token]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) { echo json_encode(["success" => false, "message" => "Invalid token"]); exit(); }

// 2. Get Default Shipping Address
$addrStmt = $pdo->prepare("SELECT street_address, city FROM shipping_addresses WHERE user_id = ? LIMIT 1");
$addrStmt->execute([$user['id']]);
$address = $addrStmt->fetch(PDO::FETCH_ASSOC);

$fullAddress = $address ? $address['street_address'] . ", " . $address['city'] : "No address provided";
$phone = $user['phone'] ?? "No phone provided";

echo json_encode([
    "success" => true,
    "user" =>[
        "id" => $user['id'],
        "name" => $user['firstname'] . " " . $user['lastname'],
        "email" => $user['email'],
        "phone" => $phone,
        "address" => $fullAddress
    ]
]);
?>