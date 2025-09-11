<?php

namespace App\Models;

use App\Core\Database;

class Constant {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance();
    }

    // --- Sites ---
    public function getAllSites() {
        // **اصلاح شد:** نام ستون از site_name به name تغییر کرد
        $this->db->query("SELECT * FROM sites ORDER BY name ASC");
        return $this->db->fetchAll();
    }
    public function findSiteById($id) {
        $this->db->query("SELECT * FROM sites WHERE id = :id");
        $this->db->bind(':id', $id);
        return $this->db->fetch();
    }
    public function addSite($data) {
        $this->db->query("INSERT INTO sites (name, url) VALUES (:name, :url)");
        $this->db->bind(':name', $data['name']);
        $this->db->bind(':url', $data['url']);
        return $this->db->execute();
    }
    public function updateSite($id, $data) {
        $this->db->query("UPDATE sites SET name = :name, url = :url WHERE id = :id");
        $this->db->bind(':name', $data['name']);
        $this->db->bind(':url', $data['url']);
        $this->db->bind(':id', $id);
        return $this->db->execute();
    }
    public function deleteSite($id) {
        $this->db->query("DELETE FROM sites WHERE id = :id");
        $this->db->bind(':id', $id);
        return $this->db->execute();
    }

    // --- Other methods from original file ---
    public function getAllOrderStatuses() {
        $this->db->query("SELECT * FROM order_statuses");
        return $this->db->fetchAll();
    }
    public function addOrderStatus($data) { /* ... original code ... */ }
    public function deleteOrderStatus($id) { /* ... original code ... */ }
    public function getAllShippingRates() { /* ... original code ... */ }
    public function addShippingRate($data) { /* ... original code ... */ }
    public function deleteShippingRate($id) { /* ... original code ... */ }
    public function getAllTicketCategories() { /* ... original code ... */ }
    public function addTicketCategory($name) { /* ... original code ... */ }
    public function deleteTicketCategory($id) { /* ... original code ... */ }
}
