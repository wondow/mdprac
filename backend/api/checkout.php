<?php
require 'db.php';



// 1. Force Apache to give us the Authorization header (Even if it tries to hide it)
$headers = null;
if (isset($_SERVER['Authorization'])) {
    $headers = trim($_SERVER["Authorization"]);
} else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { // Nginx or fast CGI
    $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
} elseif (function_exists('apache_request_headers')) {
    $requestHeaders = apache_request_headers();
    // Server-side fix for mixed case headers
    $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
    if (isset($requestHeaders['Authorization'])) {
        $headers = trim($requestHeaders['Authorization']);
    }
}

// Extract the token string
$token = null;
if (!empty($headers)) {
    if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
        $token = $matches[1];
    }
}

if (!$token) {
    echo json_encode(["success" => false, "message" => "Unauthorized access. No token found."]);
    exit();
}

// ... rest of the file stays exactly the same ...
if (!$token) {
    echo json_encode(["success" => false, "message" => "Unauthorized access. Please log in."]);
    exit();
}

// 2. Find the user based on the token
$stmt = $pdo->prepare("SELECT id FROM users WHERE api_token = ?");
$stmt->execute([$token]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    echo json_encode(["success" => false, "message" => "Invalid token. Please log in again."]);
    exit();
}

// 3. Process the incoming JSON order data
$data = json_decode(file_get_contents("php://input"), true);
$totalAmount = $data['total_amount'] ?? 0;
$items = $data['items'] ?? [];

if (empty($items)) {
    echo json_encode(["success" => false, "message" => "Your cart is empty."]);
    exit();
}

try {
    // Start a Database Transaction (If one item fails, the whole order is canceled)
    $pdo->beginTransaction();

    // 4. Create the Main Order Record
    $orderStmt = $pdo->prepare("INSERT INTO orders (user_id, shipping_address_id, total_amount, status) VALUES (?, 1, ?, 'pending')");
    $orderStmt->execute([$user['id'], $totalAmount]);
    $orderId = $pdo->lastInsertId();

    $itemStmt = $pdo->prepare("INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)");
    
    foreach ($items as $item) {
        $itemStmt->execute([
            $orderId,
            $item['product_id'],
            $item['quantity'],
            $item['price']
        ]);
        
       
    }

    // Commit the transaction
    $pdo->commit();

    echo json_encode(["success" => true, "message" => "Order placed successfully! Order #DS-" . str_pad($orderId, 4, '0', STR_PAD_LEFT)]);

} catch (Exception $e) {
    // If anything fails, rollback the database to its previous state
    $pdo->rollBack();
    echo json_encode(["success" => false, "message" => "Failed to process order: " . $e->getMessage()]);
}
?>