<?php
require 'db.php';

$action = $_GET['action'] ?? '';
$data = json_decode(file_get_contents("php://input"), true);

if ($action === 'register') {
    $first = $data['firstname'];
    $last = $data['lastname'];
    $email = $data['email'];
    $pass = password_hash($data['password'], PASSWORD_DEFAULT);

    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email, password_hash) VALUES (?, ?, ?, ?)");
    if ($stmt->execute([$first, $last, $email, $pass])) {
        echo json_encode(["success" => true, "message" => "Account created"]);
    } else {
        echo json_encode(["success" => false, "message" => "Email already exists"]);
    }
} 
elseif ($action === 'login') {
    $email = $data['email'];
    $password = $data['password'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password_hash'])) {
        $token = bin2hex(random_bytes(32)); // Generate simple API token
        $pdo->prepare("UPDATE users SET api_token = ? WHERE id = ?")->execute([$token, $user['id']]);
        
        echo json_encode([
            "success" => true, 
            "token" => $token, 
            "user" => ["id" => $user['id'], "name" => $user['firstname'], "email" => $user['email']]
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid credentials"]);
    }
}