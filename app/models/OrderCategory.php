<?php

namespace App\Models;

use App\Core\Database;

class OrderCategory {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    public function getAll() {
        $this->db->query("SELECT * FROM order_categories ORDER BY name ASC");
        return $this->db->fetchAll();
    }

    public function findById($id) {
        $this->db->query("SELECT * FROM order_categories WHERE id = :id");
        $this->db->bind(':id', $id);
        return $this->db->fetch();
    }

    public function create($data) {
        $this->db->query("INSERT INTO order_categories (name) VALUES (:name)");
        $this->db->bind(':name', $data['name']);
        return $this->db->execute();
    }

    public function update($id, $data) {
        $this->db->query("UPDATE order_categories SET name = :name WHERE id = :id");
        $this->db->bind(':name', $data['name']);
        $this->db->bind(':id', $id);
        return $this->db->execute();
    }

    public function delete($id) {
        $this->db->query("DELETE FROM order_categories WHERE id = :id");
        $this->db->bind(':id', $id);
        return $this->db->execute();
    }
}
