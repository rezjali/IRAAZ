<?php

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;

class RateController extends Controller {

    private $rateModel;

    public function __construct() {
        Auth::authenticate();
        $this->rateModel = $this->model('Rate');
    }

    public function index() {
        // Auto-backfill: if no active lira rate exists, import from settings.lira_rate once
        $existingLira = $this->rateModel->getByType('lira');
        if (empty($existingLira)) {
            $settingModel = $this->model('Setting');
            $settings = $settingModel->getAllAsAssoc();
            if (!empty($settings['lira_rate'])) {
                $this->rateModel->create([
                    'rate_type' => 'lira',
                    'title' => 'نرخ انتقال‌یافته',
                    'amount_toman' => (float)$settings['lira_rate'],
                    'is_active' => 1
                ]);
            }
        }

        $data = [
            'title' => 'نرخ‌ها',
            'lira' => $this->rateModel->getByType('lira'),
            'shipping' => $this->rateModel->getByType('shipping'),
            'cargo' => $this->rateModel->getByType('cargo'),
            'store' => $this->rateModel->getByType('store')
        ];
        $this->view('settings/rates', $data);
    }

    public function store() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') redirect('rates');
        $data = [
            'rate_type' => $_POST['rate_type'] ?? '',
            'title' => $_POST['title'] ?? '',
            'amount_toman' => (float)($_POST['amount_toman'] ?? 0),
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
        ];
        if (!in_array($data['rate_type'], ['lira','shipping','cargo','store'])) redirect('rates');
        $this->rateModel->create($data);
        redirect('rates');
    }

    public function update() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') redirect('rates');
        $id = (int)($_POST['id'] ?? 0);
        if (!$id) redirect('rates');
        $data = [
            'title' => $_POST['title'] ?? '',
            'amount_toman' => (float)($_POST['amount_toman'] ?? 0),
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
        ];
        $this->rateModel->update($id, $data);
        redirect('rates');
    }

    public function delete() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') redirect('rates');
        $id = (int)($_POST['id'] ?? 0);
        if ($id) $this->rateModel->delete($id);
        redirect('rates');
    }
}


