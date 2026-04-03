<?php
require_once 'db.php';

$action = $_GET['action'] ?? '';

if ($action === 'get_all') {
    // Fetch all products and JOIN their category name
    $stmt = $pdo->query("
        SELECT p.*, c.name as category_name 
        FROM products p 
        LEFT JOIN categories c ON p.category_id = c.id
        ORDER BY p.id DESC
    ");
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $products
    ]);
} 
elseif ($action === 'get_categories') {
    $stmt = $pdo->query("SELECT * FROM categories");
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $categories
    ]);
}