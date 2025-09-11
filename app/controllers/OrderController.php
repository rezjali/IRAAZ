<?php

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;

class OrderController extends Controller {

    private $orderModel;
    private $userModel;
    private $constantModel;

    public function __construct() {
        Auth::authenticate();
        $this->orderModel = $this->model('Order');
        $this->userModel = $this->model('User');
        $this->constantModel = $this->model('Constant');
    }

    public function index() { $this->displayOrders('active', 'مدیریت سفارشات'); }
    public function cancelledIndex() { $this->displayOrders('cancelled', 'سفارشات کنسل شده'); }
    public function deletedIndex() { $this->displayOrders('deleted', 'سفارشات حذف شده'); }
    public function suspendedIndex() { $this->displayOrders('suspended', 'سفارشات معلق شده'); }

    private function displayOrders($category, $title) {
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        $perPage = 15;
        $filters = ['search' => $_GET['search'] ?? null, 'status_id' => isset($_GET['status_id']) && $_GET['status_id'] !== '' ? (int)$_GET['status_id'] : null, 'category' => $category];
        $orders = $this->orderModel->getAll($page, $perPage, $filters);
        
        foreach ($orders as $order) {
            if (empty($order->tracking_code)) {
                $trackingCode = 'NLY-' . $order->id . '-' . random_int(100, 999);
                $barcodeUrl = 'https://barcode.tec-it.com/barcode.ashx?data=' . $trackingCode . '&code=Code128';
                $this->orderModel->updateOrderCodes($order->id, $trackingCode, $barcodeUrl);
                $order->tracking_code = $trackingCode;
                $order->barcode_url = $barcodeUrl;
            }
        }

        $totalOrders = $this->orderModel->getTotalCount($filters);
        $statuses = $this->orderModel->getStatusesByCategory($category);
        $all_statuses = $this->orderModel->getOrderStatuses();
        $totalPages = ceil($totalOrders / $perPage);

        if (!empty($filters['status_id'])) {
            foreach ($statuses as $status) { if ($status->id == $filters['status_id']) { $title = $status->status_name; break; } }
        }
        $data = ['title' => $title, 'orders' => $orders, 'statuses' => $statuses, 'all_statuses' => $all_statuses, 'pagination' => ['current_page' => $page, 'total_pages' => $totalPages, 'per_page' => $perPage, 'total_items' => $totalOrders], 'current_category' => $category];
        $this->view('orders/index', $data);
    }
    
    public function create() {
        $data = ['title' => 'ثبت سفارش جدید', 'customers' => $this->userModel->getAllCustomers(), 'categories' => $this->orderModel->getOrderCategories(), 'sites' => $this->constantModel->getAllSites()];
        $this->view('orders/create', $data);
    }

    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') redirect('orders');
        if (empty($_POST['user_id']) || empty($_POST['title']) || empty($_POST['price_toman'])) {
            $data = ['title' => 'ثبت سفارش جدید', 'customers' => $this->userModel->getAllCustomers(), 'categories' => $this->orderModel->getOrderCategories(), 'sites' => $this->constantModel->getAllSites(), 'error' => 'فیلدهای الزامی را پر کنید.'];
            $this->view('orders/create', $data); return;
        }
        $imageName = null;
        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            $targetDir = PUBLIC_PATH . "/uploads/orders/";
            if (!is_dir($targetDir)) mkdir($targetDir, 0755, true);
            $imageName = time() . '_' . basename($_FILES["image"]["name"]);
            $targetFile = $targetDir . $imageName;
            if (!move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) $imageName = null;
        }
        // <<< FIX: Added product_link to the data array for creation
        $data = [
            'user_id' => (int)$_POST['user_id'], 
            'title' => $_POST['title'], 
            'image' => $imageName, 
            'source_site' => $_POST['source_site'] ?? '', 
            'quantity' => (int)($_POST['quantity'] ?? 1), 
            'size' => $_POST['size'] ?? '', 
            'price_lira' => (float)($_POST['price_lira'] ?? 0), 
            'price_toman' => (float)$_POST['price_toman'], 
            'weight' => (float)($_POST['weight'] ?? 0), 
            'apply_shipping' => isset($_POST['apply_shipping']) ? 1 : 0, 
            'with_cargo' => isset($_POST['with_cargo']) ? 1 : 0, 
            'is_store_purchase' => isset($_POST['is_store_purchase']) ? 1 : 0, 
            'category_id' => !empty($_POST['category_id']) ? (int)$_POST['category_id'] : null, 
            'description' => $_POST['description'] ?? '', 
            'product_link' => $_POST['product_link'] ?? '', // This line is new
            'status_id' => 1
        ];
        $orderId = $this->orderModel->createOrder($data);
        if ($orderId) {
            $trackingCode = 'NLY-' . $orderId . '-' . random_int(100, 999);
            $barcodeUrl = 'https://barcode.tec-it.com/barcode.ashx?data=' . $trackingCode . '&code=Code128';
            $this->orderModel->updateOrderCodes($orderId, $trackingCode, $barcodeUrl);
            set_flash_message('success', 'سفارش جدید با موفقیت ثبت شد.');
            redirect('orders');
        } else {
            $data = ['title' => 'ثبت سفارش جدید', 'customers' => $this->userModel->getAllCustomers(), 'categories' => $this->orderModel->getOrderCategories(), 'sites' => $this->constantModel->getAllSites(), 'error' => 'خطا در ثبت سفارش.'];
            $this->view('orders/create', $data);
        }
    }

    public function show() {
        $id = $_GET['id'] ?? null;
        if (!$id) redirect('orders');
        $order = $this->orderModel->getOrderById($id);
        if (!$order) redirect('orders');
        $data = ['title' => 'جزئیات سفارش #' . $order->id, 'order' => $order];
        $this->view('orders/show', $data);
    }

    public function edit() {
        $id = $_GET['id'] ?? null;
        if (!$id) redirect('orders');
        $order = $this->orderModel->getOrderById($id);
        if (!$order) redirect('orders');
        $data = ['title' => 'ویرایش سفارش #' . $id, 'order' => $order, 'customers' => $this->userModel->getAllCustomers(), 'categories' => $this->orderModel->getOrderCategories(), 'sites' => $this->constantModel->getAllSites()];
        $this->view('orders/edit', $data);
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') redirect('orders');
        $id = $_POST['id'] ?? null;
        if (!$id) redirect('orders');
        
        $order = $this->orderModel->getOrderById($id);
        $imageName = $order->image;

        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            $targetDir = PUBLIC_PATH . "/uploads/orders/";
            if (!is_dir($targetDir)) mkdir($targetDir, 0755, true);
            $imageName = time() . '_' . basename($_FILES["image"]["name"]);
            $targetFile = $targetDir . $imageName;
            if (!move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) $imageName = $order->image;
        }

        // <<< FIX: Added product_link and corrected total_cost for update
        $data = [
            'user_id' => (int)$_POST['user_id'], 
            'title' => $_POST['title'], 
            'image' => $imageName, 
            'source_site' => $_POST['source_site'] ?? '', 
            'quantity' => (int)($_POST['quantity'] ?? 1), 
            'size' => $_POST['size'] ?? '', 
            'price_lira' => (float)($_POST['price_lira'] ?? 0), 
            'price_toman' => (float)$_POST['price_toman'], 
            'weight' => (float)($_POST['weight'] ?? 0), 
            'apply_shipping' => isset($_POST['apply_shipping']) ? 1 : 0, 
            'with_cargo' => isset($_POST['with_cargo']) ? 1 : 0, 
            'is_store_purchase' => isset($_POST['is_store_purchase']) ? 1 : 0, 
            'category_id' => !empty($_POST['category_id']) ? (int)$_POST['category_id'] : null, 
            'description' => $_POST['description'] ?? '',
            'product_link' => $_POST['product_link'] ?? '', // This line is updated
            'total_cost' => (float)$_POST['price_toman'] 
        ];
        
        if ($this->orderModel->updateOrder($id, $data)) {
            set_flash_message('success', 'سفارش با موفقیت به‌روزرسانی شد.');
            redirect('orders');
        } else {
            set_flash_message('error', 'خطایی در به‌روزرسانی سفارش رخ داد.');
            redirect('orders/edit?id=' . $id);
        }
    }

    public function updateStatus() {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $orderId = $_POST['order_id'];
            $statusId = $_POST['status_id'];
            if ($this->orderModel->updateStatus($orderId, $statusId)) {
                set_flash_message('success', 'وضعیت سفارش #' . $orderId . ' با موفقیت تغییر کرد.');
            } else {
                set_flash_message('error', 'خطا در تغییر وضعیت سفارش.');
            }
        }
        $referer = $_SERVER['HTTP_REFERER'] ?? APP_URL . '/orders';
        $path = str_replace(APP_URL, '', $referer);
        redirect(ltrim($path, '/'));
    }
}
