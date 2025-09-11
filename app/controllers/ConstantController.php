<?php

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;

class ConstantController extends Controller {

    private $constantModel;

    public function __construct() {
        Auth::authenticate();
        $this->constantModel = $this->model('Constant');
    }

    // --- Order Statuses ---
    public function orderStatuses() {
        $data = ['title' => 'مدیریت وضعیت سفارش', 'statuses' => $this->constantModel->getAllOrderStatuses()];
        $this->view('constants/order_statuses', $data);
    }
    public function storeOrderStatus() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['status_name'])) {
            $this->constantModel->addOrderStatus(['status_name' => $_POST['status_name'], 'status_category' => $_POST['status_category']]);
        }
        redirect('constants/order-statuses');
    }
    public function deleteOrderStatus() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['id'])) {
            $this->constantModel->deleteOrderStatus((int)$_POST['id']);
        }
        redirect('constants/order-statuses');
    }

    // --- Shipping Rates ---
    public function shippingRates() {
        $data = ['title' => 'مدیریت نرخ باربری', 'rates' => $this->constantModel->getAllShippingRates()];
        $this->view('constants/shipping_rates', $data);
    }
    public function storeShippingRate() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['description']) && isset($_POST['cost'])) {
            $this->constantModel->addShippingRate(['description' => $_POST['description'], 'cost' => (float)$_POST['cost']]);
        }
        redirect('constants/shipping-rates');
    }
    public function deleteShippingRate() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['id'])) {
            $this->constantModel->deleteShippingRate((int)$_POST['id']);
        }
        redirect('constants/shipping-rates');
    }

    // --- Source Sites (FIXED SECTION) ---
    // FIX: This function now correctly maps database columns (name, url) to what the view expects (site_name, site_url)
    public function sites() {
        $sitesFromDb = $this->constantModel->getAllSites();
        $sitesForView = [];
        foreach ($sitesFromDb as $site) {
            $sitesForView[] = (object)[
                'id' => $site->id,
                'site_name' => $site->name, // Mapping 'name' to 'site_name'
                'site_url' => $site->url     // Mapping 'url' to 'site_url'
            ];
        }
        $data = ['title' => 'مدیریت سایت‌ها', 'sites' => $sitesForView];
        $this->view('constants/sites', $data);
    }
    
    // FIX: Reverted to original camelCase name and correctly map POST data to database columns
    public function storeSite() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['site_name']) && !empty($_POST['site_url'])) {
            // Map incoming form data to the correct database column names
            $dataToSave = [
                'name' => $_POST['site_name'], 
                'url' => $_POST['site_url']
            ];
            $this->constantModel->addSite($dataToSave);
        }
        redirect('constants/sites');
    }
    
    // FIX: Reverted to original camelCase name and correctly map data for the view
    public function editSite() {
        $id = $_GET['id'] ?? null;
        if (!$id) redirect('constants/sites');
        $site = $this->constantModel->findSiteById($id);
        
        // Map database object to what the view expects
        $siteForView = (object)[
            'id' => $site->id,
            'site_name' => $site->name,
            'site_url' => $site->url
        ];

        $data = ['title' => 'ویرایش سایت', 'site' => $siteForView];
        $this->view('constants/edit_site', $data);
    }
    
    // FIX: Reverted to original camelCase name and correctly map POST data to database columns
    public function updateSite() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['id'])) {
            // Map incoming form data to the correct database column names
            $dataToSave = [
                'name' => $_POST['site_name'], 
                'url' => $_POST['site_url']
            ];
            $this->constantModel->updateSite($_POST['id'], $dataToSave);
        }
        redirect('constants/sites');
    }
    
    // FIX: Reverted to original camelCase name
    public function deleteSite() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['id'])) {
            $this->constantModel->deleteSite((int)$_POST['id']);
        }
        redirect('constants/sites');
    }

    // --- Ticket Categories ---
    public function ticketCategories() {
        $data = ['title' => 'دسته‌بندی تیکت', 'categories' => $this->constantModel->getAllTicketCategories()];
        $this->view('constants/ticket_categories', $data);
    }
    public function storeTicketCategory() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['name'])) {
            $this->constantModel->addTicketCategory($_POST['name']);
        }
        redirect('constants/ticket-categories');
    }
    public function deleteTicketCategory() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['id'])) {
            $this->constantModel->deleteTicketCategory((int)$_POST['id']);
        }
        redirect('constants/ticket-categories');
    }
}
