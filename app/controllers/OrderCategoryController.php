<?php

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;

class OrderCategoryController extends Controller {

    private $categoryModel;

    public function __construct() {
        Auth::authenticate();
        $this->categoryModel = $this->model('OrderCategory');
    }

    public function index() {
        $data = [
            'title' => 'مدیریت دسته‌بندی‌های سفارش',
            'categories' => $this->categoryModel->getAll()
        ];
        $this->view('order_categories/index', $data);
    }

    public function create() {
        $data = [
            'title' => 'ایجاد دسته‌بندی جدید'
        ];
        $this->view('order_categories/create', $data);
    }

    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST' || empty($_POST['name'])) {
            redirect('order-categories/create');
            return;
        }
        $this->categoryModel->create(['name' => $_POST['name']]);
        redirect('order-categories');
    }

    public function edit() {
        $id = $_GET['id'] ?? null;
        if (!$id) {
            redirect('order-categories');
            return;
        }
        $category = $this->categoryModel->findById($id);
        $data = [
            'title' => 'ویرایش دسته‌بندی',
            'category' => $category
        ];
        $this->view('order_categories/edit', $data);
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST' || empty($_POST['id']) || empty($_POST['name'])) {
            redirect('order-categories');
            return;
        }
        $this->categoryModel->update($_POST['id'], ['name' => $_POST['name']]);
        redirect('order-categories');
    }

    public function destroy() {
        $id = $_POST['id'] ?? null;
        if ($id) {
            $this->categoryModel->delete($id);
        }
        redirect('order-categories');
    }
}
