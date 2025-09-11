<?php

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;

class SettingsController extends Controller {

    private $settingModel;

    public function __construct() {
        Auth::authenticate();
        // In a real application, you should add a role check here
        // to ensure only super admins can access these settings.
        $this->settingModel = $this->model('Setting');
    }

    /**
     * Display the main, tabbed settings page for Site & Branding.
     */
    public function index() {
        $data = [
            'title' => 'تنظیمات سایت و برندینگ',
            'settings' => $this->settingModel->getAllAsAssoc()
        ];
        $this->view('settings/index', $data);
    }

    /**
     * Display the order settings page.
     */
    public function orderSettings() {
        $orderModel = $this->model('Order');
        $data = [
            'title' => 'تنظیمات سفارش‌ها',
            'settings' => $this->settingModel->getAllAsAssoc(),
            'statuses' => $orderModel->getOrderStatuses()
        ];
        $this->view('settings/order_settings', $data);
    }

    /**
     * Display the SMS settings page.
     */
    public function smsSettings() {
        $data = [
            'title' => 'تنظیمات پیامک',
            'settings' => $this->settingModel->getAllAsAssoc()
        ];
        $this->view('settings/sms_settings', $data);
    }

    /**
     * Display the ticket settings page.
     */
    public function ticketSettings() {
        $data = [
            'title' => 'تنظیمات تیکت',
            'settings' => $this->settingModel->getAllAsAssoc()
        ];
        $this->view('settings/ticket_settings', $data);
    }

    /**
     * Handle updates for Site & Branding settings.
     */
    public function updateSiteAndBranding() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            
            // Collect all POST data.
            $postData = [
                'site_name' => $_POST['site_name'] ?? '',
                'site_url' => $_POST['site_url'] ?? '',
                'lira_rate' => $_POST['lira_rate'] ?? '',
                'theme_primary_color' => $_POST['theme_primary_color'] ?? '#0d6efd',
                'theme_sidebar_bg' => $_POST['theme_sidebar_bg'] ?? '#212529',
                'theme_sidebar_text' => $_POST['theme_sidebar_text'] ?? '#adb5bd',
                'theme_body_bg' => $_POST['theme_body_bg'] ?? '#f8f9fa',
                'theme_card_bg' => $_POST['theme_card_bg'] ?? '#ffffff',
            ];

            // Helper function to handle file uploads.
            $uploadFile = function($fileKey, $prefix) {
                if (isset($_FILES[$fileKey]) && $_FILES[$fileKey]['error'] === UPLOAD_ERR_OK) {
                    $uploadDir = 'uploads/';
                    if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);
                    
                    $fileExtension = pathinfo($_FILES[$fileKey]['name'], PATHINFO_EXTENSION);
                    $fileName = $prefix . '.' . $fileExtension;
                    $targetPath = $uploadDir . $fileName;
                    
                    if (move_uploaded_file($_FILES[$fileKey]['tmp_name'], $targetPath)) {
                        // Add a version query to the path to bust browser cache
                        return 'uploads/' . $fileName . '?v=' . time();
                    }
                }
                return null;
            };

            // Handle all possible file uploads
            if ($logoPath = $uploadFile('site_logo', 'logo')) {
                $postData['site_logo_url'] = $logoPath;
            }
            if ($faviconPath = $uploadFile('site_favicon', 'favicon')) {
                $postData['site_favicon_url'] = $faviconPath;
            }
            if ($loginBgPath = $uploadFile('login_bg', 'login_bg')) {
                $postData['login_bg_url'] = $loginBgPath;
            }

            foreach ($postData as $key => $value) {
                $this->settingModel->updateSetting($key, $value);
            }
            set_flash_message('success', 'تنظیمات با موفقیت به‌روز شد.');
        }
        // Redirect back to the page the form was submitted from
        header('Location: ' . $_SERVER['HTTP_REFERER']);
        exit();
    }
}

