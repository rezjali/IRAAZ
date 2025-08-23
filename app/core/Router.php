<?php

namespace App\Core;

use Exception;

class Router {
    protected $routes = ['GET' => [], 'POST' => []];

    public function get($uri, $action) {
        $this->routes['GET'][$this->formatUri($uri)] = $action;
    }

    public function post($uri, $action) {
        $this->routes['POST'][$this->formatUri($uri)] = $action;
    }

    private function formatUri($uri) {
        return trim($uri, '/');
    }

    public function dispatch() {
        $uri = $this->getUri();
        $method = $_SERVER['REQUEST_METHOD'];

        if (array_key_exists($uri, $this->routes[$method])) {
            $this->callAction(...$this->routes[$method][$uri]);
            return;
        }

        // آرایه‌ی کامل مسیرهای دستی برای مدیریت تمام قابلیت‌های جدید
        $manualRoutes = [
            'GET' => [
                'orders/show' => ['App\\Controllers\\OrderController', 'show'],
                'orders/edit' => ['App\\Controllers\\OrderController', 'edit'],
                'order-categories' => ['App\\Controllers\\OrderCategoryController', 'index'],
                'order-categories/create' => ['App\\Controllers\\OrderCategoryController', 'create'],
                'order-categories/edit' => ['App\\Controllers\\OrderCategoryController', 'edit'],
                'constants/sites' => ['App\\Controllers\\ConstantController', 'sites'],
                'constants/editSite' => ['App\\Controllers\\ConstantController', 'editSite'],
            ],
            'POST' => [
                'orders/update' => ['App\\Controllers\\OrderController', 'update'],
                'orders/update-status' => ['App\\Controllers\\OrderController', 'updateStatus'],
                'order-categories/store' => ['App\\Controllers\\OrderCategoryController', 'store'],
                'order-categories/update' => ['App\\Controllers\\OrderCategoryController', 'update'],
                'order-categories/destroy' => ['App\\Controllers\\OrderCategoryController', 'destroy'],
                'constants/storeSite' => ['App\\Controllers\\ConstantController', 'storeSite'],
                'constants/updateSite' => ['App\\Controllers\\ConstantController', 'updateSite'],
                'constants/deleteSite' => ['App\\Controllers\\ConstantController', 'deleteSite'],
            ]
        ];

        if (isset($manualRoutes[$method][$uri])) {
            $this->callAction(...$manualRoutes[$method][$uri]);
            return;
        }

        throw new Exception('No route defined for this URI.');
    }

    protected function getUri() {
        $uri = trim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');
        $baseUrl = trim(parse_url(APP_URL, PHP_URL_PATH), '/');
        if ($baseUrl && strpos($uri, $baseUrl) === 0) {
            $uri = substr($uri, strlen($baseUrl));
        }
        return trim($uri, '/');
    }

    protected function callAction($controller, $method) {
        if (!class_exists($controller)) { throw new Exception("Controller {$controller} does not exist."); }
        $controllerInstance = new $controller();
        if (!method_exists($controllerInstance, $method)) { throw new Exception("Method {$method} does not exist in controller {$controller}."); }
        $controllerInstance->$method();
    }
}
