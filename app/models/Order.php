<?php

namespace App\Models;

use App\Core\Database;

class Order {
    private $db;

    public function __construct() { $this->db = Database::getInstance(); }
    public function getOrderById($id) {
        $sql = "SELECT o.*, u.full_name as customer_name, os.status_name, oc.name as category_name FROM orders o JOIN users u ON o.user_id = u.id JOIN order_statuses os ON o.status_id = os.id LEFT JOIN order_categories oc ON o.category_id = oc.id WHERE o.id = :id";
        $this->db->query($sql); $this->db->bind(':id', $id); return $this->db->fetch();
    }
    public function getAll($page, $perPage, $filters = []) {
        $sql = "SELECT o.*, u.full_name as customer_name, os.status_name, oc.name as category_name FROM orders o JOIN users u ON o.user_id = u.id JOIN order_statuses os ON o.status_id = os.id LEFT JOIN order_categories oc ON o.category_id = oc.id WHERE 1=1";
        if (!empty($filters['category'])) $sql .= " AND os.status_category = :category";
        if (!empty($filters['search'])) $sql .= " AND (o.id LIKE :search OR u.full_name LIKE :search OR o.title LIKE :search OR o.tracking_code LIKE :search)";
        if (!empty($filters['status_id'])) $sql .= " AND o.status_id = :status_id";
        $sql .= " ORDER BY o.created_at DESC LIMIT :limit OFFSET :offset";
        $this->db->query($sql);
        if (!empty($filters['category'])) $this->db->bind(':category', $filters['category']);
        if (!empty($filters['search'])) $this->db->bind(':search', '%' . $filters['search'] . '%');
        if (!empty($filters['status_id'])) $this->db->bind(':status_id', $filters['status_id']);
        $this->db->bind(':limit', $perPage); $this->db->bind(':offset', ($page - 1) * $perPage); return $this->db->fetchAll();
    }
    public function getTotalCount($filters = []) {
        $sql = "SELECT COUNT(o.id) as total FROM orders o JOIN users u ON o.user_id = u.id JOIN order_statuses os ON o.status_id = os.id WHERE 1=1";
        if (!empty($filters['category'])) $sql .= " AND os.status_category = :category";
        if (!empty($filters['search'])) $sql .= " AND (o.id LIKE :search OR u.full_name LIKE :search OR o.title LIKE :search OR o.tracking_code LIKE :search)";
        if (!empty($filters['status_id'])) $sql .= " AND o.status_id = :status_id";
        $this->db->query($sql);
        if (!empty($filters['category'])) $this->db->bind(':category', $filters['category']);
        if (!empty($filters['search'])) $this->db->bind(':search', '%' . $filters['search'] . '%');
        if (!empty($filters['status_id'])) $this->db->bind(':status_id', $filters['status_id']);
        return $this->db->fetch()->total ?? 0;
    }
    public function getOrderStatuses($category = null) {
        $sql = "SELECT id, status_name FROM order_statuses";
        if ($category) $sql .= " WHERE status_category = :category";
        $sql .= " ORDER BY id";
        $this->db->query($sql);
        if ($category) $this->db->bind(':category', $category); return $this->db->fetchAll();
    }
    public function getStatusesByCategory($category) { return $this->getOrderStatuses($category); }
    public function getStatusCount($statusId) { $this->db->query("SELECT COUNT(id) as count FROM orders WHERE status_id = :status_id"); $this->db->bind(':status_id', $statusId); return $this->db->fetch()->count ?? 0; }
    public function getRecentOrders($limit = 5) { $this->db->query("SELECT o.id, u.full_name as customer_name, os.status_name, o.created_at FROM orders o JOIN users u ON o.user_id = u.id JOIN order_statuses os ON o.status_id = os.id ORDER BY o.created_at DESC LIMIT :limit"); $this->db->bind(':limit', $limit); return $this->db->fetchAll(); }
    public function createOrder($data) {
        $sql = "INSERT INTO orders (user_id, status_id, title, image, source_site, quantity, size, price_lira, price_toman, weight, apply_shipping, with_cargo, is_store_purchase, category_id, description, product_link, total_cost) VALUES (:user_id, :status_id, :title, :image, :source_site, :quantity, :size, :price_lira, :price_toman, :weight, :apply_shipping, :with_cargo, :is_store_purchase, :category_id, :description, :product_link, :total_cost)";
        $this->db->query($sql);
        $this->db->bind(':user_id', $data['user_id']); $this->db->bind(':status_id', $data['status_id']); $this->db->bind(':title', $data['title']); $this->db->bind(':image', $data['image']); $this->db->bind(':source_site', $data['source_site']); $this->db->bind(':quantity', $data['quantity']); $this->db->bind(':size', $data['size']); $this->db->bind(':price_lira', $data['price_lira']); $this->db->bind(':price_toman', $data['price_toman']); $this->db->bind(':weight', $data['weight']); $this->db->bind(':apply_shipping', $data['apply_shipping']); $this->db->bind(':with_cargo', $data['with_cargo']); $this->db->bind(':is_store_purchase', $data['is_store_purchase']); $this->db->bind(':category_id', $data['category_id']); $this->db->bind(':description', $data['description']); $this->db->bind(':product_link', $data['source_site']); $this->db->bind(':total_cost', $data['price_toman']);
        if ($this->db->execute()) { return $this->db->lastInsertId(); } return false;
    }
    public function updateOrderCodes($orderId, $trackingCode, $barcodeUrl) {
        $sql = "UPDATE orders SET tracking_code = :tracking_code, barcode_url = :barcode_url WHERE id = :id";
        $this->db->query($sql); $this->db->bind(':tracking_code', $trackingCode); $this->db->bind(':barcode_url', $barcodeUrl); $this->db->bind(':id', $orderId); return $this->db->execute();
    }
    public function updateOrder($id, $data) {
        $sql = "UPDATE orders SET user_id = :user_id, title = :title, image = :image, source_site = :source_site, quantity = :quantity, size = :size, price_lira = :price_lira, price_toman = :price_toman, weight = :weight, apply_shipping = :apply_shipping, with_cargo = :with_cargo, is_store_purchase = :is_store_purchase, category_id = :category_id, description = :description, product_link = :source_site, total_cost = :price_toman WHERE id = :id";
        $this->db->query($sql);
        $this->db->bind(':id', $id); $this->db->bind(':user_id', $data['user_id']); $this->db->bind(':title', $data['title']); $this->db->bind(':image', $data['image']); $this->db->bind(':source_site', $data['source_site']); $this->db->bind(':quantity', $data['quantity']); $this->db->bind(':size', $data['size']); $this->db->bind(':price_lira', $data['price_lira']); $this->db->bind(':price_toman', $data['price_toman']); $this->db->bind(':weight', $data['weight']); $this->db->bind(':apply_shipping', $data['apply_shipping']); $this->db->bind(':with_cargo', $data['with_cargo']); $this->db->bind(':is_store_purchase', $data['is_store_purchase']); $this->db->bind(':category_id', $data['category_id']); $this->db->bind(':description', $data['description']);
        return $this->db->execute();
    }
    public function getOrderCategories() { $this->db->query("SELECT * FROM order_categories ORDER BY name ASC"); return $this->db->fetchAll(); }
    public function getUrgentOrders($limit = 5) { $this->db->query("SELECT o.id, u.full_name as customer_name, o.created_at FROM orders o JOIN users u ON o.user_id = u.id WHERE o.status_id = 1 AND o.created_at < DATE_SUB(NOW(), INTERVAL 24 HOUR) ORDER BY o.created_at ASC LIMIT :limit"); $this->db->bind(':limit', $limit); return $this->db->fetchAll(); }
    
    // متد جدید برای آپدیت وضعیت
    public function updateStatus($orderId, $statusId) {
        $this->db->query("UPDATE orders SET status_id = :status_id WHERE id = :id");
        $this->db->bind(':status_id', $statusId);
        $this->db->bind(':id', $orderId);
        return $this->db->execute();
    }
}
