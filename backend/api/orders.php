<?php
require 'db.php';

// 1. Get and Validate Token
$headers = null;
if (isset($_SERVER['Authorization'])) {
    $headers = trim($_SERVER["Authorization"]);
} else if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
    $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
} elseif (function_exists('apache_request_headers')) {
    $requestHeaders = apache_request_headers();
    $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
    if (isset($requestHeaders['Authorization'])) {
        $headers = trim($requestHeaders['Authorization']);
    }
}

$token = null;
if (!empty($headers) && preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
    $token = $matches[1];
}

if (!$token) {
    echo json_encode(["success" => false, "message" => "Unauthorized"]);
    exit();
}

$stmt = $pdo->prepare("SELECT id FROM users WHERE api_token = ?");
$stmt->execute([$token]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    echo json_encode(["success" => false, "message" => "Invalid token"]);
    exit();
}

// 2. Fetch Order History for this specific user
// We use a subquery to quickly count how many items are in each order
$orderStmt = $pdo->prepare("
    SELECT 
        id, 
        total_amount, 
        status, 
        created_at,
        (SELECT SUM(quantity) FROM order_items WHERE order_id = orders.id) as item_count
    FROM orders 
    WHERE user_id = ? 
    ORDER BY created_at DESC
");
$orderStmt->execute([$user['id']]);
$orders = $orderStmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode([
    "success" => true,
    "data" => $orders
]);
?>