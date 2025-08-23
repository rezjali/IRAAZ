-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 23, 2025 at 01:36 AM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_nilayteamirnaaz`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `action` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `name`, `slug`) VALUES
(1, 'اخبار', 'news'),
(2, 'راهنمای خرید', 'buying-guides');

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `status` enum('published','draft') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(10) UNSIGNED NOT NULL,
  `uploader_id` int(10) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'برای زیرمنوها',
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `group_id`, `parent_id`, `title`, `url`, `sort_order`) VALUES
(1, 1, NULL, 'صفحه اصلی', '/', 0),
(2, 1, NULL, 'درباره ما', '/about-us', 1),
(3, 1, NULL, 'تماس با ما', '/contact-us', 2);

-- --------------------------------------------------------

--
-- Table structure for table `menu_groups`
--

CREATE TABLE `menu_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'مثال: منوی اصلی، منوی فوتر',
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_groups`
--

INSERT INTO `menu_groups` (`id`, `name`, `slug`) VALUES
(1, 'منوی اصلی هدر', 'main-header-menu');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'عنوان سفارش',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'مسیر تصویر سفارش',
  `source_site` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سایت مبدا خرید',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT 'تعداد محصول',
  `status_id` int(10) UNSIGNED NOT NULL,
  `suitcase_id` int(10) UNSIGNED DEFAULT NULL,
  `assigned_to_user_id` int(10) UNSIGNED DEFAULT NULL,
  `product_link` text NOT NULL,
  `product_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'شامل سایز، رنگ، تعداد و ...' CHECK (json_valid(`product_details`)),
  `price_try` decimal(10,2) NOT NULL COMMENT 'قیمت به لیر',
  `exchange_rate` decimal(10,2) NOT NULL COMMENT 'نرخ تبدیل ارز',
  `commission_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `shipping_cost` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(15,2) NOT NULL,
  `cancellation_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `order_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci DEFAULT NULL COMMENT 'مسیر تصویر سفارش',
  `size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci DEFAULT NULL COMMENT 'سایز محصول',
  `price_lira` decimal(10,2) DEFAULT NULL COMMENT 'قیمت به لیر',
  `price_toman` bigint(20) DEFAULT 0 COMMENT 'قیمت به تومان',
  `weight` decimal(10,2) DEFAULT NULL COMMENT 'وزن کالا به کیلوگرم',
  `tracking_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'کد رهگیری پستی',
  `barcode_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'لینک بارکد تولید شده',
  `apply_shipping` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'آیا هزینه باربری اعمال شود؟ 0=خیر, 1=بله',
  `apply_shipping_fee` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'اعمال هزینه باربری - 0: خیر, 1: بله',
  `category_id` int(11) DEFAULT NULL COMMENT 'شناسه دسته بندی',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode_link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_persian_ci DEFAULT NULL COMMENT 'لینک بارکد',
  `with_cargo` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'با کارگو - 0: خیر, 1: بله',
  `is_store_purchase` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'آیا خرید از استور است؟ 0=خیر, 1=بله',
  `store_purchase` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'خرید استور - 0: خیر, 1: بله'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `title`, `image`, `source_site`, `quantity`, `status_id`, `suitcase_id`, `assigned_to_user_id`, `product_link`, `product_details`, `price_try`, `exchange_rate`, `commission_fee`, `shipping_cost`, `total_cost`, `cancellation_notes`, `created_at`, `updated_at`, `order_image`, `size`, `price_lira`, `price_toman`, `weight`, `tracking_code`, `barcode_url`, `apply_shipping`, `apply_shipping_fee`, `category_id`, `description`, `barcode_link`, `with_cargo`, `is_store_purchase`, `store_purchase`) VALUES
(1, 3, NULL, NULL, NULL, 1, 1, NULL, NULL, 'https://www.zara.com/tr/en/zw-collection-wide-leg-high-waist-jeans-p09632253.html?v1=463551051&utm_campaign=productShare&utm_medium=mobile_sharing_iOS&utm_source=red_social_movil ', '{\"size\":\"36\",\"color\":\"Sefid\",\"quantity\":\"1\"}', 1690.00, 2235.00, 20.00, 350000.00, 4882580.00, NULL, '2025-07-29 20:47:50', '2025-08-23 01:26:11', NULL, NULL, NULL, 0, NULL, 'NLY-1-807', 'https://barcode.tec-it.com/barcode.ashx?data=NLY-1-807&code=Code128', 0, 0, NULL, NULL, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_categories`
--

CREATE TABLE `order_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_persian_ci;

--
-- Dumping data for table `order_categories`
--

INSERT INTO `order_categories` (`id`, `name`, `created_at`) VALUES
(1, 'لباس زنانه', '2025-08-22 23:56:24');

-- --------------------------------------------------------

--
-- Table structure for table `order_statuses`
--

CREATE TABLE `order_statuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `status_name` varchar(255) NOT NULL,
  `status_category` enum('active','suspended','cancelled','deleted') NOT NULL COMMENT 'دسته‌بندی برای منوها',
  `is_cancellation` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_statuses`
--

INSERT INTO `order_statuses` (`id`, `status_name`, `status_category`, `is_cancellation`) VALUES
(1, 'ثبت شد', 'active', 0),
(2, 'خرید شد', 'active', 0),
(3, 'تفکیک شد ترکیه', 'active', 0),
(4, 'بسته بندی', 'active', 0),
(5, 'ارسال شد', 'active', 0),
(6, 'تفکیک شد تهران', 'active', 0),
(7, 'تحویل مشتری', 'active', 0),
(8, 'معلق شده', 'suspended', 0),
(10, 'مفقودی در انبار ترکیه', 'cancelled', 1),
(11, 'مفقودی به وسیله تفکیک کار تهران', 'cancelled', 1),
(12, 'مفقود از سمت کارگو و سایت مرجع', 'cancelled', 1),
(13, 'معیوب از سمت سایت مرجع', 'cancelled', 1),
(14, 'اشتباه رنگ/مدل/سایز از سمت سایت مرجع', 'cancelled', 1),
(15, 'به درخواست مشتری', 'cancelled', 1),
(16, 'کنسل از سمت سایت مرجع', 'cancelled', 1),
(17, 'لینک اشتباه', 'cancelled', 1),
(18, 'سایز موجود نیست', 'cancelled', 1),
(19, 'مغایرت قیمت', 'cancelled', 1),
(20, 'مغایرت تعداد', 'cancelled', 1),
(21, 'لینک و عکس مغایر', 'cancelled', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `page_title` varchar(255) NOT NULL COMMENT 'عنوان صفحه',
  `page_slug` varchar(255) NOT NULL COMMENT 'اسلاگ برای URL (منحصر به فرد)',
  `page_content` longtext DEFAULT NULL COMMENT 'محتوای صفحه (HTML)',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `page_title`, `page_slug`, `page_content`, `updated_at`) VALUES
(1, 'درباره ما', 'about-us', '<p>محتوای صفحه درباره ما در اینجا قرار می‌گیرد.</p>', '2025-07-28 01:26:02'),
(2, 'تماس با ما', 'contact-us', '<p>اطلاعات تماس با ما.</p>', '2025-07-28 01:26:02'),
(3, 'قوانین و مقررات', 'terms-and-conditions', '<p>متن کامل قوانین و مقررات سایت.</p>', '2025-07-28 01:26:02');

-- --------------------------------------------------------

--
-- Table structure for table `payment_receipts`
--

CREATE TABLE `payment_receipts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `wallet_type` enum('product','shipping') NOT NULL,
  `receipt_url` varchar(255) NOT NULL COMMENT 'مسیر فایل آپلود شده',
  `notes` text DEFAULT NULL COMMENT 'یادداشت کاربر',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `reviewed_by` int(10) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_key` varchar(100) NOT NULL COMMENT 'کلید انگلیسی دسترسی',
  `description` varchar(255) NOT NULL COMMENT 'توضیح فارسی دسترسی',
  `category` varchar(100) NOT NULL COMMENT 'دسته‌بندی برای نمایش بهتر'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `permission_key`, `description`, `category`) VALUES
(44, 'view_dashboard', 'مشاهده داشبورد', 'داشبورد'),
(45, 'view_financial_summary_widget', 'مشاهده ویجت خلاصه مالی در داشبورد', 'داشبورد'),
(46, 'view_urgent_orders_widget', 'مشاهده ویجت سفارشات فوری در داشبورد', 'داشبورد'),
(47, 'view_own_orders', 'مشاهده سفارشات خود', 'سفارشات'),
(48, 'view_all_orders', 'مشاهده تمام سفارشات (ادمین)', 'سفارشات'),
(49, 'create_order', 'ایجاد سفارش جدید برای خود (مشتری)', 'سفارشات'),
(50, 'create_order_for_others', 'ایجاد سفارش برای دیگران (ادمین)', 'سفارشات'),
(51, 'edit_own_order', 'ویرایش سفارشات خود (قبل از خرید)', 'سفارشات'),
(52, 'edit_any_order', 'ویرایش تمام سفارشات (ادمین)', 'سفارشات'),
(53, 'cancel_own_order', 'کنسل کردن سفارش خود', 'سفارشات'),
(54, 'change_any_order_status', 'تغییر وضعیت تمام سفارشات (ادمین)', 'سفارشات'),
(55, 'view_task_assignment_page', 'مشاهده صفحه تفکیک کار', 'تفکیک کار'),
(56, 'assign_order_to_purchaser', 'تخصیص سفارش به مسئول خرید', 'تفکیک کار'),
(57, 'view_suitcases', 'مشاهده لیست چمدان‌ها', 'چمدان‌ها'),
(58, 'create_suitcase', 'ایجاد چمدان جدید', 'چمدان‌ها'),
(59, 'edit_suitcase', 'ویرایش اطلاعات چمدان', 'چمدان‌ها'),
(60, 'assign_order_to_suitcase', 'تخصیص سفارش به چمدان', 'چمدان‌ها'),
(61, 'remove_order_from_suitcase', 'حذف سفارش از چمدان', 'چمدان‌ها'),
(62, 'view_own_wallet', 'مشاهده کیف پول خود', 'مالی'),
(63, 'view_all_wallets', 'مشاهده کیف پول تمام کاربران (ادمین)', 'مالی'),
(64, 'view_own_transactions', 'مشاهده تراکنش‌های خود', 'مالی'),
(65, 'view_all_transactions', 'مشاهده تمام تراکنش‌ها (ادمین)', 'مالی'),
(66, 'submit_payment_receipt', 'ثبت فیش واریزی برای شارژ کیف پول', 'مالی'),
(67, 'manage_all_receipts', 'تایید/رد تمام فیش‌های واریزی (ادمین)', 'مالی'),
(68, 'manage_credit_assignment', 'اختصاص/کسر اعتبار دستی (ادمین)', 'مالی'),
(69, 'view_sales_stats', 'مشاهده آمار فروش (ادمین)', 'مالی'),
(70, 'view_debtors_list', 'مشاهده لیست بدهکاران (ادمین)', 'مالی'),
(71, 'view_users_list', 'مشاهده لیست کاربران (ادمین)', 'کاربران و پروفایل'),
(72, 'create_user', 'ایجاد کاربر جدید (ادمین)', 'کاربران و پروفایل'),
(73, 'edit_user', 'ویرایش اطلاعات کاربران (ادمین)', 'کاربران و پروفایل'),
(74, 'delete_user', 'حذف کاربران (ادمین)', 'کاربران و پروفایل'),
(75, 'view_own_profile', 'مشاهده پروفایل خود', 'کاربران و پروفایل'),
(76, 'edit_own_profile', 'ویرایش پروفایل خود', 'کاربران و پروفایل'),
(77, 'view_roles', 'مشاهده لیست نقش‌ها', 'نقش‌ها و دسترسی‌ها'),
(78, 'manage_permissions', 'ویرایش دسترسی‌های نقش‌ها', 'نقش‌ها و دسترسی‌ها'),
(79, 'create_role', 'ایجاد نقش جدید', 'نقش‌ها و دسترسی‌ها'),
(80, 'manage_pages', 'مدیریت صفحات محتوایی', 'محتوا'),
(81, 'manage_blog', 'مدیریت کامل وبلاگ (مقالات و دسته‌ها)', 'محتوا'),
(82, 'manage_images', 'مدیریت گالری تصاویر', 'محتوا'),
(83, 'manage_menus', 'مدیریت منوهای سایت', 'محتوا'),
(84, 'create_ticket', 'ایجاد تیکت جدید', 'پشتیبانی (تیکت‌ها)'),
(85, 'view_own_tickets', 'مشاهده تیکت‌های خود', 'پشتیبانی (تیکت‌ها)'),
(86, 'view_all_tickets', 'مشاهده تمام تیکت‌ها (ادمین)', 'پشتیبانی (تیکت‌ها)'),
(87, 'reply_to_tickets', 'پاسخ به تیکت‌ها', 'پشتیبانی (تیکت‌ها)'),
(88, 'manage_general_settings', 'مدیریت تنظیمات اصلی و پایه', 'تنظیمات'),
(89, 'manage_system_constants', 'مدیریت مقادیر ثابت (وضعیت‌ها، نرخ‌ها و ...)', 'تنظیمات'),
(90, 'view_activity_logs', 'مشاهده لاگ فعالیت کاربران', 'لاگ‌ها و آمار'),
(91, 'view_visitor_logs', 'مشاهده آمار بازدید', 'لاگ‌ها و آمار');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL COMMENT 'نام فارسی نقش',
  `role_key` varchar(50) NOT NULL COMMENT 'کلید انگلیسی برای استفاده در کد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `role_key`) VALUES
(1, 'مدیر کل', 'super_admin'),
(2, 'مشتری', 'customer'),
(3, 'مدیر میانی', 'admin'),
(4, 'مسئول خرید', 'purchaser'),
(5, 'مسئول انبار ترکیه', 'warehouse_turkey'),
(6, 'مسئول انبار تهران', 'warehouse_tehran');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('default_commission_rate', '10'),
('default_try_exchange_rate', '2000'),
('login_bg_url', ''),
('order_allow_new', '1'),
('order_default_status_on_create', '1'),
('order_send_sms_on_status_change', '0'),
('site_favicon_url', ''),
('site_logo_url', ''),
('site_name', 'آی راز'),
('site_url', 'http://nilayteam.ir/irnaaz/'),
('sms_api_key', ''),
('sms_enabled', '0'),
('sms_sender_number', ''),
('sms_template_status_change', 'مشتری گرامی، وضعیت سفارش شما به \"{status}\" تغییر یافت.'),
('theme_body_bg', '#f8f9fa'),
('theme_card_bg', '#ffffff'),
('theme_primary_color', '#0d6efd'),
('theme_sidebar_bg', '#212529'),
('theme_sidebar_text', '#adb5bd'),
('ticket_allow_new', '1'),
('ticket_auto_close_days', '7');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_rates`
--

CREATE TABLE `shipping_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'توضیح ردیف، مثال: تا ۱ کیلوگرم',
  `cost` decimal(15,2) NOT NULL COMMENT 'هزینه به تومان',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipping_rates`
--

INSERT INTO `shipping_rates` (`id`, `description`, `cost`, `is_active`, `created_at`) VALUES
(6, 'پوشاک', 500000.00, 1, '2025-07-29 20:44:29');

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sites`
--

INSERT INTO `sites` (`id`, `name`, `url`, `created_at`) VALUES
(1, 'ترندیول', 'https://try.com', '2025-08-23 00:46:02');

-- --------------------------------------------------------

--
-- Table structure for table `source_sites`
--

CREATE TABLE `source_sites` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_name` varchar(255) NOT NULL COMMENT 'نام سایت',
  `site_url` varchar(255) NOT NULL COMMENT 'آدرس وب‌سایت',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `source_sites`
--

INSERT INTO `source_sites` (`id`, `site_name`, `site_url`, `is_active`, `created_at`) VALUES
(1, 'Trendyol', 'https://www.trendyol.com', 1, '2025-07-28 01:23:02'),
(2, 'Zara Turkey', 'https://www.zara.com/tr/', 1, '2025-07-28 01:23:02'),
(3, 'H&M Turkey', 'https://www2.hm.com/tr_tr/', 1, '2025-07-28 01:23:02');

-- --------------------------------------------------------

--
-- Table structure for table `suitcases`
--

CREATE TABLE `suitcases` (
  `id` int(10) UNSIGNED NOT NULL,
  `suitcase_code` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `shipped_at` timestamp NULL DEFAULT NULL,
  `arrived_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `status` enum('open','answered','closed') NOT NULL DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_categories`
--

CREATE TABLE `ticket_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket_categories`
--

INSERT INTO `ticket_categories` (`id`, `name`, `is_active`) VALUES
(1, 'پشتیبانی مالی', 1),
(2, 'پیگیری سفارش', 1),
(3, 'فنی', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'کاربر پاسخ دهنده',
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `wallet_type` enum('product','shipping') NOT NULL COMMENT 'نوع کیف پول',
  `transaction_type` enum('deposit','withdrawal','order_payment','refund') NOT NULL,
  `description` varchar(255) NOT NULL,
  `receipt_url` varchar(255) DEFAULT NULL COMMENT 'لینک فیش واریزی',
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `order_id`, `amount`, `wallet_type`, `transaction_type`, `description`, `receipt_url`, `is_approved`, `created_at`) VALUES
(1, 3, NULL, 500000000.00, 'product', 'deposit', '', NULL, 1, '2025-07-29 20:55:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT 2,
  `full_name` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT 'Hashed password',
  `phone` varchar(20) DEFAULT NULL,
  `wallet_product` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'کیف پول کالا',
  `wallet_shipping` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'کیف پول باربری',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `full_name`, `username`, `email`, `password`, `phone`, `wallet_product`, `wallet_shipping`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'مدیر کل سیستم', 'admin', 'admin@example.com', '$2y$10$gymz7lPGFTdHAlvpgs.xkODpFQfzPrwki4bM8kIZ79AzCMkRVUp0u', '09105949489', 0.00, 0.00, 1, '2025-07-27 23:40:57', '2025-07-28 21:44:54'),
(3, 2, 'Golnaz', 'golnaz', 'golnazplv@gmail.com', '$2y$10$2.xiC3n30SVXn1vpI3cVbuEsKtlKJuExsaD7/LuRK27ulsIesm03K', '05071805008', 500000000.00, 0.00, 1, '2025-07-29 20:40:57', '2025-08-22 23:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `user_announcements`
--

CREATE TABLE `user_announcements` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `announcement_id` int(10) UNSIGNED NOT NULL,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text NOT NULL,
  `request_uri` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visitor_logs`
--

INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(1, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 17:28:29'),
(2, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:28:29'),
(3, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:46:21'),
(4, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:46:21'),
(5, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:46:39'),
(6, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:46:39'),
(7, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:50:12'),
(8, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:50:19'),
(9, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 17:50:19'),
(10, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/reset_password.php', '2025-07-28 17:52:22'),
(11, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/reset_password.php', '2025-07-28 17:52:57'),
(12, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:03:17'),
(13, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:03:35'),
(14, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:03:35'),
(15, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:04:12'),
(16, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:04:12'),
(17, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:04:32'),
(18, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:04:32'),
(19, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:10:18'),
(20, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:10:26'),
(21, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:10:26'),
(22, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:10:49'),
(23, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:10:49'),
(24, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:12:55'),
(25, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:13:03'),
(26, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:13:03'),
(27, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:15:52'),
(28, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:15:59'),
(29, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:15:59'),
(30, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:18:28'),
(31, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:18:35'),
(32, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:21:54'),
(33, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:22:02'),
(34, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:22:28'),
(35, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:24:50'),
(36, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:24:50'),
(37, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:24:57'),
(38, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:24:57'),
(39, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:30:55'),
(40, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:31:13'),
(41, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:33:36'),
(42, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:33:38'),
(43, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:33:39'),
(44, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:34:03'),
(45, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:47:26'),
(46, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:47:36'),
(47, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 18:47:47'),
(48, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:47:47'),
(49, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 18:47:56'),
(50, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:47:56'),
(51, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/announcements/user', '2025-07-28 18:48:09'),
(52, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:48:13'),
(53, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 18:48:18'),
(54, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 18:48:19'),
(55, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 18:48:23'),
(56, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 18:48:27'),
(57, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 18:48:34'),
(58, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:50:14'),
(59, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 18:50:14'),
(60, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 18:58:26'),
(61, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 18:58:28'),
(62, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 18:58:32'),
(63, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 18:58:38'),
(64, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:04:24'),
(65, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:04:26'),
(66, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:04:38'),
(67, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:06:53'),
(68, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:07:01'),
(69, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:08:39'),
(70, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:08:48'),
(71, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:09:05'),
(72, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:12:25'),
(73, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:12:27'),
(74, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:12:34'),
(75, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:12:51'),
(76, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:14:53'),
(77, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 19:15:01'),
(78, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 19:15:03'),
(79, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:15:07'),
(80, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 19:16:03'),
(81, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:16:05'),
(82, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/cancelled-orders', '2025-07-28 19:19:37'),
(83, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/menus', '2025-07-28 19:19:41'),
(84, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:19:47'),
(85, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logs/activity', '2025-07-28 19:19:50'),
(86, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/orders', '2025-07-28 19:19:55'),
(87, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 19:20:04'),
(88, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 19:20:06'),
(89, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 19:20:15'),
(90, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:20:18'),
(91, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 19:20:20'),
(92, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 19:20:43'),
(93, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 19:20:57'),
(94, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 19:21:31'),
(95, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:21:38'),
(96, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 19:21:41'),
(97, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logs/activity', '2025-07-28 19:21:54'),
(98, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/images', '2025-07-28 19:21:57'),
(99, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 19:22:04'),
(100, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 19:22:08'),
(101, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-28 19:22:18'),
(102, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-28 19:22:27'),
(103, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 19:22:32'),
(104, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:24:53'),
(105, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 19:25:04'),
(106, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:03:20'),
(107, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:03:29'),
(108, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:09:48'),
(109, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:09:59'),
(110, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 20:10:18'),
(111, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-07-28 20:10:26'),
(112, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/product', '2025-07-28 20:10:34'),
(113, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:11:11'),
(114, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:11:30'),
(115, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:11:32'),
(116, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:11:40'),
(117, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 20:12:01'),
(118, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/product', '2025-07-28 20:12:18'),
(119, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:13:19'),
(120, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:13:24'),
(121, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:22:33'),
(122, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:22:41'),
(123, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:22:41'),
(124, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 20:22:44'),
(125, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 20:22:49'),
(126, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-28 20:22:50'),
(127, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-28 20:22:52'),
(128, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-28 20:22:55'),
(129, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-28 20:22:57'),
(130, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 20:23:00'),
(131, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 20:23:03'),
(132, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:23:07'),
(133, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 20:23:12'),
(134, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 20:23:15'),
(135, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:23:19'),
(136, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 20:23:46'),
(137, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 20:24:35'),
(138, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/product', '2025-07-28 20:24:42'),
(139, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/shipping', '2025-07-28 20:24:45'),
(140, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/transactions/product', '2025-07-28 20:24:47'),
(141, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 20:24:49'),
(142, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/receipts/product', '2025-07-28 20:24:55'),
(143, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/receipts/shipping', '2025-07-28 20:24:57'),
(144, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/sales-stats', '2025-07-28 20:24:58'),
(145, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/debtors', '2025-07-28 20:25:01'),
(146, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:25:04'),
(147, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/cancelled-orders', '2025-07-28 20:25:26'),
(148, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:25:28'),
(149, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/cancelled-orders?status_id=10', '2025-07-28 20:25:33'),
(150, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:25:35'),
(151, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/cancelled-orders?search=&status_id=', '2025-07-28 20:25:41'),
(152, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-07-28 20:25:54'),
(153, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-07-28 20:26:13'),
(154, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/deleted-orders', '2025-07-28 20:26:17'),
(155, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 20:26:40'),
(156, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:26:44'),
(157, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:27:09'),
(158, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:27:37'),
(159, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:27:40'),
(160, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:27:45'),
(161, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 20:27:48'),
(162, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:29:05'),
(163, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:29:40'),
(164, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:29:43'),
(165, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 20:29:44'),
(166, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:29:48'),
(167, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-07-28 20:29:52'),
(168, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/deleted-orders', '2025-07-28 20:29:58'),
(169, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 20:30:01'),
(170, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:30:05'),
(171, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:30:07'),
(172, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:30:11'),
(173, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:36:31'),
(174, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:36:46'),
(175, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:37:22'),
(176, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:37:25'),
(177, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:37:27'),
(178, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:37:29'),
(179, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:37:38'),
(180, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 20:37:41'),
(181, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:37:43'),
(182, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:37:49'),
(183, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 20:37:50'),
(184, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:37:53'),
(185, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 20:37:56'),
(186, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 20:38:03'),
(187, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 20:38:08'),
(188, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:38:18'),
(189, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 20:38:29'),
(190, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:38:38'),
(191, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-07-28 20:38:49'),
(192, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:38:52'),
(193, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:38:54'),
(194, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/deleted-orders', '2025-07-28 20:39:02'),
(195, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:39:10'),
(196, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:39:25'),
(197, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:39:51'),
(198, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:41:49'),
(199, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:41:55'),
(200, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:42:31'),
(201, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 20:42:36'),
(202, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:42:40'),
(203, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:42:44'),
(204, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:43:27'),
(205, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:44:12'),
(206, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:44:25'),
(207, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:47:13'),
(208, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:47:19'),
(209, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:47:24'),
(210, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-28 20:47:29'),
(211, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 20:47:32'),
(212, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 20:47:36'),
(213, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:47:39'),
(214, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:47:51'),
(215, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:51:37'),
(216, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 20:51:53'),
(217, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 20:59:56'),
(218, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 20:59:59'),
(219, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 21:00:02'),
(220, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:00:04'),
(221, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 21:00:06'),
(222, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:00:08'),
(223, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 21:00:09'),
(224, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:00:11'),
(225, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 21:00:16'),
(226, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:00:27'),
(227, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:00:33'),
(228, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 21:00:36'),
(229, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:00:43'),
(230, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 21:00:52'),
(231, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:00:58'),
(232, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:01:31'),
(233, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 21:01:48'),
(234, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 21:02:22'),
(235, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:02:46'),
(236, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/sales-stats', '2025-07-28 21:02:55'),
(237, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:02:57'),
(238, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 21:03:04'),
(239, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-28 21:03:10'),
(240, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:03:19'),
(241, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 21:03:21'),
(242, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:03:25'),
(243, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 21:03:28'),
(244, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:03:51'),
(245, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:18:42'),
(246, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:18:50'),
(247, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:18:52'),
(248, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:19:03'),
(249, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:19:10'),
(250, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:19:52'),
(251, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 21:19:54'),
(252, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 21:20:00'),
(253, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:20:32'),
(254, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:00'),
(255, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 21:21:02'),
(256, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:04'),
(257, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:21:08'),
(258, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:21:10'),
(259, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:40'),
(260, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:40'),
(261, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:42'),
(262, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:21:43'),
(263, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:21:46'),
(264, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:22:32'),
(265, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:22:35'),
(266, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/store', '2025-07-28 21:23:33'),
(267, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:23:34'),
(268, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 21:23:38'),
(269, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:23:39'),
(270, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:23:47'),
(271, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:23:47'),
(272, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:23:50'),
(273, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 21:23:54'),
(274, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:23:55');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(275, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:01'),
(276, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:24:01'),
(277, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:24:08'),
(278, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile/update', '2025-07-28 21:24:22'),
(279, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:24:22'),
(280, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:24:26'),
(281, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 21:24:28'),
(282, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:28'),
(283, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:32'),
(284, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:33'),
(285, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:41'),
(286, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:41'),
(287, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:48'),
(288, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:48'),
(289, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:57'),
(290, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:24:58'),
(291, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/reset_password.php', '2025-07-28 21:25:16'),
(292, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:25:22'),
(293, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:25:22'),
(294, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:25:25'),
(295, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:25:25'),
(296, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:25:29'),
(297, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:25:32'),
(298, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:26:16'),
(299, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile/update', '2025-07-28 21:26:23'),
(300, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:26:23'),
(301, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:27:14'),
(302, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:33:47'),
(303, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=2', '2025-07-28 21:33:50'),
(304, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 21:33:55'),
(305, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:33:59'),
(306, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=2', '2025-07-28 21:34:00'),
(307, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:34:14'),
(308, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=1', '2025-07-28 21:34:15'),
(309, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:35:20'),
(310, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=1', '2025-07-28 21:39:25'),
(311, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:39:30'),
(312, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:39:33'),
(313, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=1', '2025-07-28 21:39:35'),
(314, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=2', '2025-07-28 21:39:39'),
(315, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:39:48'),
(316, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=2', '2025-07-28 21:40:20'),
(317, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:40:57'),
(318, NULL, '128.90.174.7', 'WhatsApp/2.23.20.0', '/irnaaz/', '2025-07-28 21:43:52'),
(319, NULL, '128.90.174.7', 'WhatsApp/2.23.20.0', '/irnaaz/login', '2025-07-28 21:43:52'),
(320, NULL, '128.90.174.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-28 21:43:58'),
(321, NULL, '128.90.174.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-28 21:43:58'),
(322, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:44:33'),
(323, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:44:35'),
(324, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=2', '2025-07-28 21:44:37'),
(325, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:44:42'),
(326, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=1', '2025-07-28 21:44:45'),
(327, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/update', '2025-07-28 21:44:54'),
(328, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=1', '2025-07-28 21:44:54'),
(329, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 21:44:59'),
(330, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:44:59'),
(331, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 21:45:02'),
(332, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:45:02'),
(333, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 21:49:43'),
(334, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases/create', '2025-07-28 21:49:45'),
(335, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-28 21:49:50'),
(336, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 21:49:53'),
(337, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 21:50:02'),
(338, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 21:50:07'),
(339, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases/create', '2025-07-28 21:50:12'),
(340, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 21:50:16'),
(341, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:50:17'),
(342, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:51:08'),
(343, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 21:51:10'),
(344, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins/create', '2025-07-28 21:51:12'),
(345, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:51:19'),
(346, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:51:21'),
(347, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:51:25'),
(348, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:51:28'),
(349, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:51:29'),
(350, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 21:51:32'),
(351, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins/create', '2025-07-28 21:51:33'),
(352, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:51:37'),
(353, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 21:51:39'),
(354, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:51:40'),
(355, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 21:56:04'),
(356, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:56:07'),
(357, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 21:56:10'),
(358, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-28 21:57:38'),
(359, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 21:57:41'),
(360, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:01:40'),
(361, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 22:01:42'),
(362, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:01:56'),
(363, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/store', '2025-07-28 22:02:03'),
(364, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:02:07'),
(365, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:03:05'),
(366, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 22:03:14'),
(367, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:03:15'),
(368, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 22:03:30'),
(369, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:03:31'),
(370, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:03:38'),
(371, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:03:41'),
(372, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-28 22:03:44'),
(373, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-28 22:03:45'),
(374, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses/store', '2025-07-28 22:03:50'),
(375, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-28 22:03:50'),
(376, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses/delete', '2025-07-28 22:03:57'),
(377, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-28 22:03:58'),
(378, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-28 22:04:00'),
(379, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories/store', '2025-07-28 22:04:05'),
(380, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-28 22:04:06'),
(381, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories/delete', '2025-07-28 22:04:09'),
(382, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-28 22:04:10'),
(383, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-28 22:04:11'),
(384, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/store', '2025-07-28 22:04:22'),
(385, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-28 22:04:22'),
(386, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/delete', '2025-07-28 22:04:25'),
(387, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-28 22:04:26'),
(388, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 22:04:28'),
(389, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites/store', '2025-07-28 22:04:44'),
(390, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 22:04:44'),
(391, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites/delete', '2025-07-28 22:04:47'),
(392, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 22:04:48'),
(393, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:04:49'),
(394, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:08:08'),
(395, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:08:12'),
(396, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 22:08:15'),
(397, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 22:08:18'),
(398, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins/create', '2025-07-28 22:08:20'),
(399, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:08:23'),
(400, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/store', '2025-07-28 22:08:29'),
(401, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:08:29'),
(402, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=7', '2025-07-28 22:08:33'),
(403, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:08:36'),
(404, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 22:09:08'),
(405, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:09:12'),
(406, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/tasks', '2025-07-28 22:09:20'),
(407, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:12:58'),
(408, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/edit?id=2', '2025-07-28 22:13:00'),
(409, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:13:02'),
(410, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles/delete', '2025-07-28 22:13:06'),
(411, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/roles', '2025-07-28 22:13:06'),
(412, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:13:09'),
(413, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 22:13:13'),
(414, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:13:44'),
(415, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:13:48'),
(416, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:13:50'),
(417, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:13:59'),
(418, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:14:01'),
(419, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:14:03'),
(420, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 22:14:10'),
(421, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:14:12'),
(422, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 22:15:35'),
(423, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 22:15:35'),
(424, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 22:16:14'),
(425, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:16:15'),
(426, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:43:21'),
(427, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:43:24'),
(428, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:43:30'),
(429, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-28 22:43:33'),
(430, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-28 22:46:54'),
(431, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:46:57'),
(432, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 22:47:00'),
(433, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-28 22:47:03'),
(434, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-07-28 22:47:08'),
(435, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/suitcases/create', '2025-07-28 22:47:10'),
(436, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:47:11'),
(437, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:48:30'),
(438, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:48:35'),
(439, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:48:39'),
(440, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-07-28 22:49:00'),
(441, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:49:03'),
(442, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:54:15'),
(443, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 22:54:19'),
(444, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:54:32'),
(445, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 22:54:49'),
(446, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 22:54:53'),
(447, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:55:05'),
(448, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:55:10'),
(449, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 22:55:12'),
(450, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 23:07:05'),
(451, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 23:07:07'),
(452, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:07:07'),
(453, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 23:07:13'),
(454, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:07:14'),
(455, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 23:07:16'),
(456, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:07:17'),
(457, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/update', '2025-07-28 23:07:31'),
(458, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:07:31'),
(459, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:07:34'),
(460, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:10:11'),
(461, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:10:13'),
(462, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:10:16'),
(463, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 23:10:18'),
(464, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:10:18'),
(465, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/branding', '2025-07-28 23:11:15'),
(466, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:11:16'),
(467, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/update', '2025-07-28 23:12:51'),
(468, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:12:52'),
(469, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:30:00'),
(470, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-28 23:30:04'),
(471, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:30:06'),
(472, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit', '2025-07-28 23:30:08'),
(473, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:30:09'),
(474, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-28 23:30:10'),
(475, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:30:12'),
(476, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:30:15'),
(477, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/update', '2025-07-28 23:30:25'),
(478, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:30:25'),
(479, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:30:28'),
(480, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:30:30'),
(481, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:07'),
(482, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:13'),
(483, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/update', '2025-07-28 23:35:30'),
(484, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:30'),
(485, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:33'),
(486, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 23:35:36'),
(487, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:35:36'),
(488, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:35:38'),
(489, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:35:40'),
(490, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:35:40'),
(491, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-07-28 23:35:43'),
(492, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:45'),
(493, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/update', '2025-07-28 23:35:50'),
(494, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-28 23:35:51'),
(495, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-28 23:36:03'),
(496, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:36:03'),
(497, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:44:43'),
(498, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:44:43'),
(499, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:45:03'),
(500, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:45:04'),
(501, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:45:26'),
(502, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:45:26'),
(503, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-28 23:46:40'),
(504, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-28 23:46:40'),
(505, NULL, '118.195.165.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 03:26:32'),
(506, NULL, '213.180.203.124', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-07-29 04:22:24'),
(507, NULL, '213.180.203.124', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-07-29 04:22:24'),
(508, NULL, '95.108.213.99', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-07-29 04:22:26'),
(509, NULL, '95.108.213.128', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-07-29 04:22:26'),
(510, NULL, '4.227.36.83', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-07-29 04:25:58'),
(511, NULL, '4.227.36.83', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-07-29 04:25:59'),
(512, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 05:58:39'),
(513, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 05:58:39'),
(514, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 05:59:40'),
(515, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 05:59:40'),
(516, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 06:00:10'),
(517, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 06:00:10'),
(518, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 06:00:10'),
(519, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 06:00:10'),
(520, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 06:25:24'),
(521, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 06:25:24'),
(522, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 06:31:17'),
(523, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 06:31:17'),
(524, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 06:36:56'),
(525, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 06:36:59'),
(526, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 07:00:23'),
(527, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 07:00:23'),
(528, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 07:00:34'),
(529, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 07:00:34'),
(530, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 07:00:53'),
(531, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 07:00:53'),
(532, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/orders?status_id=1', '2025-07-29 07:00:59'),
(533, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 07:01:04'),
(534, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/suitcases', '2025-07-29 07:01:06'),
(535, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/financial/assign-credit', '2025-07-29 07:01:17'),
(536, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/suitcases', '2025-07-29 07:01:23'),
(537, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 07:01:30'),
(538, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/deleted-orders', '2025-07-29 07:02:25'),
(539, NULL, '88.235.168.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 07:02:29'),
(540, NULL, '118.195.165.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 09:47:26'),
(541, NULL, '118.195.165.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 09:47:31'),
(542, NULL, '43.153.58.28', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-29 12:50:51'),
(543, NULL, '43.153.58.28', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 12:50:53');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(544, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 15:02:29'),
(545, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 15:02:29'),
(546, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 15:03:00'),
(547, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 15:03:00'),
(548, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 15:03:44'),
(549, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 15:03:44'),
(550, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 15:05:27'),
(551, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 15:05:27'),
(552, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 15:06:21'),
(553, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 15:06:21'),
(554, NULL, '204.18.249.73', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-29 16:22:10'),
(555, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 18:21:45'),
(556, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 18:21:45'),
(557, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 18:22:15'),
(558, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 18:22:15'),
(559, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 18:23:49'),
(560, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 18:23:50'),
(561, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 18:25:11'),
(562, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 18:25:11'),
(563, NULL, '20.171.207.190', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-07-29 18:46:13'),
(564, NULL, '20.171.207.190', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-07-29 18:46:13'),
(565, NULL, '20.171.207.190', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-07-29 18:47:07'),
(566, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 20:39:24'),
(567, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:39:24'),
(568, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:39:53'),
(569, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 20:39:53'),
(570, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-29 20:39:58'),
(571, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-29 20:40:07'),
(572, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/store', '2025-07-29 20:40:57'),
(573, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-29 20:40:57'),
(574, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 20:41:08'),
(575, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-29 20:41:17'),
(576, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:41:17'),
(577, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:41:31'),
(578, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 20:41:31'),
(579, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-07-29 20:42:52'),
(580, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-29 20:43:15'),
(581, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings', '2025-07-29 20:43:18'),
(582, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-29 20:43:24'),
(583, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:43:26'),
(584, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/store', '2025-07-29 20:44:04'),
(585, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:04'),
(586, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/delete', '2025-07-29 20:44:11'),
(587, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:11'),
(588, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/delete', '2025-07-29 20:44:18'),
(589, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:18'),
(590, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/delete', '2025-07-29 20:44:19'),
(591, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:19'),
(592, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/delete', '2025-07-29 20:44:22'),
(593, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:22'),
(594, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates/store', '2025-07-29 20:44:29'),
(595, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:44:29'),
(596, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-29 20:45:23'),
(597, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites/store', '2025-07-29 20:46:34'),
(598, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-29 20:46:34'),
(599, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders/store', '2025-07-29 20:47:50'),
(600, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-29 20:47:50'),
(601, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=1', '2025-07-29 20:48:08'),
(602, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=', '2025-07-29 20:48:28'),
(603, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=2', '2025-07-29 20:48:32'),
(604, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?search=&status_id=1', '2025-07-29 20:48:34'),
(605, 3, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/logout', '2025-07-29 20:49:04'),
(606, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:04'),
(607, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:36'),
(608, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:36'),
(609, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:53'),
(610, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:54'),
(611, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:49:56'),
(612, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:50:18'),
(613, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:50:18'),
(614, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 20:50:40'),
(615, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 20:50:40'),
(616, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=1', '2025-07-29 20:50:47'),
(617, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/debtors', '2025-07-29 20:52:11'),
(618, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=1', '2025-07-29 20:52:15'),
(619, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=2', '2025-07-29 20:53:30'),
(620, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=1', '2025-07-29 20:53:31'),
(621, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-29 20:53:35'),
(622, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-29 20:53:40'),
(623, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/create', '2025-07-29 20:53:43'),
(624, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-07-29 20:53:54'),
(625, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-07-29 20:53:58'),
(626, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/ticket-categories', '2025-07-29 20:54:19'),
(627, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-07-29 20:54:25'),
(628, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-29 20:54:30'),
(629, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites/delete', '2025-07-29 20:54:37'),
(630, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-07-29 20:54:37'),
(631, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/product', '2025-07-29 20:54:50'),
(632, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit?user_id=3', '2025-07-29 20:54:54'),
(633, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/store-credit', '2025-07-29 20:55:18'),
(634, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/transactions/product', '2025-07-29 20:55:18'),
(635, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/transactions/product', '2025-07-29 20:55:41'),
(636, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/financial/sales-stats', '2025-07-29 20:56:41'),
(637, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-29 20:56:56'),
(638, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-07-29 20:56:59'),
(639, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-07-29 20:57:12'),
(640, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/update', '2025-07-29 20:57:19'),
(641, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-07-29 20:57:19'),
(642, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/update', '2025-07-29 20:57:26'),
(643, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-07-29 20:57:26'),
(644, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-29 21:10:07'),
(645, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=1', '2025-07-29 21:10:26'),
(646, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 21:54:05'),
(647, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 21:54:05'),
(648, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 21:54:33'),
(649, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 21:54:34'),
(650, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 21:56:04'),
(651, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 21:56:04'),
(652, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-29 21:56:43'),
(653, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-29 21:56:43'),
(654, NULL, '43.157.82.252', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-30 00:26:47'),
(655, NULL, '43.157.82.252', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-30 00:26:49'),
(656, NULL, '49.51.253.83', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-30 02:03:23'),
(657, NULL, '49.51.253.83', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-30 02:03:25'),
(658, NULL, '124.226.222.66', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-30 04:34:37'),
(659, NULL, '124.226.222.66', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-30 04:34:46'),
(660, NULL, '66.249.73.201', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/', '2025-07-30 06:26:52'),
(661, NULL, '66.249.73.199', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/login', '2025-07-30 06:26:52'),
(662, NULL, '43.159.62.178', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-30 07:34:44'),
(663, NULL, '43.159.62.178', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-30 07:34:45'),
(664, NULL, '43.159.62.178', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-30 07:34:45'),
(665, NULL, '43.159.62.178', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-30 07:34:45'),
(666, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 08:00:07'),
(667, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 08:00:07'),
(668, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 08:01:35'),
(669, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 08:01:35'),
(670, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 08:02:43'),
(671, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 08:02:44'),
(672, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 08:03:05'),
(673, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 08:03:05'),
(674, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 09:49:46'),
(675, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 09:49:46'),
(676, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 09:50:11'),
(677, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 09:50:11'),
(678, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 09:51:01'),
(679, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 09:51:01'),
(680, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 09:52:34'),
(681, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 09:52:34'),
(682, NULL, '114.117.233.112', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-30 10:58:21'),
(683, NULL, '114.117.233.112', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-30 10:58:37'),
(684, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 16:01:16'),
(685, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 16:01:16'),
(686, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 16:01:26'),
(687, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 16:01:26'),
(688, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 16:01:45'),
(689, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 16:01:45'),
(690, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 16:04:49'),
(691, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 16:04:49'),
(692, NULL, '93.103.53.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/', '2025-07-30 16:59:39'),
(693, NULL, '93.103.53.239', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/login', '2025-07-30 16:59:39'),
(694, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 18:34:21'),
(695, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 18:34:21'),
(696, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-30 18:35:29'),
(697, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 18:35:29'),
(698, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-07-30 18:35:34'),
(699, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-30 18:35:47'),
(700, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-07-30 18:35:54'),
(701, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-30 18:35:57'),
(702, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/users', '2025-07-30 18:36:03'),
(703, NULL, '47.128.31.204', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)', '/irnaaz/', '2025-07-30 20:00:10'),
(704, NULL, '47.128.31.204', 'Mozilla/5.0 (Linux; Android 5.0) AppleWebKit/537.36 (KHTML, like Gecko) Mobile Safari/537.36 (compatible; Bytespider; spider-feedback@bytedance.com)', '/irnaaz/login', '2025-07-30 20:00:13'),
(705, NULL, '132.232.203.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-30 23:34:28'),
(706, NULL, '132.232.203.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-30 23:34:29'),
(707, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 01:08:08'),
(708, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 01:08:09'),
(709, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 01:10:14'),
(710, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 01:10:14'),
(711, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 01:10:33'),
(712, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 01:10:33'),
(713, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 01:11:53'),
(714, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 01:11:53'),
(715, NULL, '43.134.237.246', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-31 01:21:22'),
(716, NULL, '43.134.237.246', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-31 01:21:22'),
(717, NULL, '43.134.237.246', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-31 01:21:23'),
(718, NULL, '43.134.237.246', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-31 01:21:23'),
(719, NULL, '182.42.105.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-31 02:37:51'),
(720, NULL, '182.42.105.144', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-31 02:37:53'),
(721, NULL, '34.48.66.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-31 06:07:34'),
(722, NULL, '34.48.66.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-31 06:07:35'),
(723, NULL, '34.48.66.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-07-31 06:07:36'),
(724, NULL, '34.48.66.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-07-31 06:07:36'),
(725, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 10:26:48'),
(726, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 10:26:48'),
(727, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 10:27:55'),
(728, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 10:27:55'),
(729, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 10:27:59'),
(730, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 10:28:00'),
(731, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 10:28:42'),
(732, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 10:28:42'),
(733, NULL, '93.158.90.65', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', '/irnaaz/', '2025-07-31 11:26:50'),
(734, NULL, '93.158.90.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', '/irnaaz/login', '2025-07-31 11:26:50'),
(735, NULL, '93.158.90.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', '/irnaaz/', '2025-07-31 11:26:50'),
(736, NULL, '93.158.90.67', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', '/irnaaz/login', '2025-07-31 11:26:50'),
(737, NULL, '122.51.104.231', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-31 12:06:09'),
(738, NULL, '122.51.104.231', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-07-31 12:06:12'),
(739, NULL, '138.197.45.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 15:04:28'),
(740, NULL, '138.197.45.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 15:04:28'),
(741, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 15:53:32'),
(742, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 15:53:32'),
(743, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 15:55:08'),
(744, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 15:55:08'),
(745, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 15:55:23'),
(746, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 15:55:23'),
(747, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 15:56:39'),
(748, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 15:56:39'),
(749, NULL, '38.75.74.254', '\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36\"', '/irnaaz/', '2025-07-31 19:18:31'),
(750, NULL, '38.75.74.254', '\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36\"', '/irnaaz/login', '2025-07-31 19:18:31'),
(751, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 20:54:50'),
(752, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 20:54:51'),
(753, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 20:57:11'),
(754, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 20:57:11'),
(755, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 20:57:31'),
(756, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 20:57:31'),
(757, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-07-31 20:58:15'),
(758, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-07-31 20:58:16'),
(759, NULL, '125.94.144.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-07-31 21:34:38'),
(760, NULL, '162.252.172.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/', '2025-07-31 22:22:05'),
(761, NULL, '162.252.172.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/login', '2025-07-31 22:22:05'),
(762, NULL, '113.219.218.197', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-01 00:34:44'),
(763, NULL, '113.219.218.197', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-01 00:34:45'),
(764, NULL, '120.71.59.24', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-01 03:40:31'),
(765, NULL, '120.71.59.24', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-01 03:40:32'),
(766, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 06:12:16'),
(767, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 06:12:16'),
(768, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 06:12:46'),
(769, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 06:12:46'),
(770, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 06:13:39'),
(771, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 06:13:39'),
(772, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 06:15:36'),
(773, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 06:15:36'),
(774, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-01 06:48:51'),
(775, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-01 06:48:52'),
(776, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 16:44:37'),
(777, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 16:44:37'),
(778, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 16:46:41'),
(779, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 16:46:41'),
(780, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 16:47:39'),
(781, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 16:47:39'),
(782, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 16:47:59'),
(783, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 16:47:59'),
(784, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 19:30:43'),
(785, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 19:30:43'),
(786, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 19:31:30'),
(787, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 19:31:30'),
(788, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 19:32:49'),
(789, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-01 19:32:50'),
(790, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 19:32:50'),
(791, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-01 19:32:50'),
(792, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 05:22:41'),
(793, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 05:22:41'),
(794, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 05:23:42'),
(795, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 05:23:42'),
(796, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 05:23:42'),
(797, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 05:23:42'),
(798, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 05:23:51'),
(799, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 05:23:51'),
(800, NULL, '106.219.155.150', 'Mozilla/5.0 (Windows NT 6.2; arm64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 06:35:09'),
(801, NULL, '106.219.155.150', 'Mozilla/5.0 (Windows NT 6.2; arm64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 06:35:10'),
(802, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 07:35:20'),
(803, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 07:35:20'),
(804, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 07:36:05'),
(805, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 07:36:05');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(806, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 07:38:04'),
(807, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 07:38:04'),
(808, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-02 07:38:15'),
(809, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-02 07:38:15'),
(810, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-10 18:13:56'),
(811, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-10 18:13:56'),
(812, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-10 18:14:00'),
(813, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-10 18:14:00'),
(814, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-10 18:14:04'),
(815, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-10 18:14:04'),
(816, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users', '2025-08-10 18:14:08'),
(817, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-08-10 18:14:11'),
(818, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users', '2025-08-10 18:14:14'),
(819, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-08-10 18:14:31'),
(820, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-08-10 18:16:08'),
(821, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users', '2025-08-10 18:16:13'),
(822, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users', '2025-08-10 18:16:56'),
(823, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users/edit?id=3', '2025-08-10 18:17:01'),
(824, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-10 18:17:08'),
(825, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/users', '2025-08-10 18:17:16'),
(826, NULL, '118.195.165.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-10 21:04:30'),
(827, NULL, '118.195.165.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-10 21:04:33'),
(828, NULL, '35.94.180.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/', '2025-08-10 21:05:45'),
(829, NULL, '35.94.180.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/login', '2025-08-10 21:05:45'),
(830, NULL, '35.94.180.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/', '2025-08-10 21:05:47'),
(831, NULL, '35.94.180.77', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/login', '2025-08-10 21:05:47'),
(832, NULL, '140.143.98.18', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 00:05:09'),
(833, NULL, '140.143.98.18', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 00:05:17'),
(834, NULL, '43.165.70.220', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 00:15:45'),
(835, NULL, '43.165.70.220', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 00:15:47'),
(836, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 01:18:35'),
(837, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 01:18:35'),
(838, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 01:22:08'),
(839, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 01:22:08'),
(840, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 01:22:20'),
(841, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 01:22:20'),
(842, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 01:22:20'),
(843, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 01:22:20'),
(844, NULL, '43.130.60.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 02:36:31'),
(845, NULL, '43.130.60.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 02:36:33'),
(846, NULL, '129.211.215.233', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 03:06:19'),
(847, NULL, '129.211.215.233', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 03:06:21'),
(848, NULL, '98.82.21.179', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 03:55:52'),
(849, NULL, '98.82.21.179', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 03:56:03'),
(850, NULL, '5.133.192.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 05:08:02'),
(851, NULL, '172.245.185.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 05:34:02'),
(852, NULL, '172.245.185.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 05:34:02'),
(853, NULL, '185.202.108.34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 05:35:35'),
(854, NULL, '185.202.108.34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 05:35:35'),
(855, NULL, '43.153.87.54', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 08:24:23'),
(856, NULL, '43.153.87.54', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 08:24:25'),
(857, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 08:47:59'),
(858, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 08:47:59'),
(859, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 08:49:22'),
(860, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 08:49:22'),
(861, NULL, '132.232.165.4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 09:20:23'),
(862, NULL, '132.232.165.4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 09:20:28'),
(863, NULL, '4.227.36.109', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-11 10:07:14'),
(864, NULL, '4.227.36.109', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-11 10:07:14'),
(865, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 12:27:13'),
(866, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 12:27:16'),
(867, NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 12:40:08'),
(868, NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 12:40:09'),
(869, NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 12:41:11'),
(870, NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 12:41:11'),
(871, NULL, '213.180.203.4', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-08-11 15:32:40'),
(872, NULL, '95.108.213.80', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-08-11 15:32:41'),
(873, NULL, '139.155.139.22', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 15:41:00'),
(874, NULL, '139.155.139.22', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 15:41:07'),
(875, NULL, '46.17.174.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0) Gecko/20100101 Firefox/98.0', '/irnaaz/', '2025-08-11 16:11:39'),
(876, NULL, '46.17.174.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0) Gecko/20100101 Firefox/98.0', '/irnaaz/login', '2025-08-11 16:11:39'),
(877, NULL, '34.29.82.4', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', '/irnaaz/', '2025-08-11 16:42:26'),
(878, NULL, '34.29.82.4', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', '/irnaaz/login', '2025-08-11 16:42:26'),
(879, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 17:01:08'),
(880, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 17:01:08'),
(881, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 17:01:36'),
(882, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 17:01:37'),
(883, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 17:02:29'),
(884, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 17:02:29'),
(885, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-11 17:02:43'),
(886, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-11 17:02:43'),
(887, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-11 18:46:22'),
(888, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-11 18:46:30'),
(889, NULL, '43.130.60.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-12 00:15:44'),
(890, NULL, '43.130.60.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-12 00:15:46'),
(891, NULL, '129.211.215.233', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-12 00:45:25'),
(892, NULL, '129.211.215.233', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-12 00:45:26'),
(893, NULL, '49.51.180.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-12 01:18:26'),
(894, NULL, '49.51.180.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-12 01:18:27'),
(895, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 03:57:51'),
(896, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 03:57:51'),
(897, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 03:59:52'),
(898, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 03:59:52'),
(899, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 04:00:46'),
(900, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 04:00:47'),
(901, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 04:01:51'),
(902, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 04:01:51'),
(903, NULL, '44.234.24.25', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', '/irnaaz/', '2025-08-12 04:30:52'),
(904, NULL, '44.234.24.25', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', '/irnaaz/login', '2025-08-12 04:30:53'),
(905, NULL, '35.87.204.211', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', '/irnaaz/', '2025-08-12 06:17:31'),
(906, NULL, '35.87.204.211', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', '/irnaaz/login', '2025-08-12 06:17:31'),
(907, NULL, '40.77.167.184', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/', '2025-08-12 06:54:50'),
(908, NULL, '40.77.167.184', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/login', '2025-08-12 06:54:50'),
(909, NULL, '40.77.167.184', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/', '2025-08-12 06:54:50'),
(910, NULL, '40.77.167.184', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/login', '2025-08-12 06:54:50'),
(911, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 08:10:39'),
(912, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 08:10:39'),
(913, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 08:10:48'),
(914, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 08:10:48'),
(915, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 08:11:27'),
(916, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 08:11:27'),
(917, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 08:13:05'),
(918, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 08:13:05'),
(919, NULL, '40.77.167.7', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/', '2025-08-12 12:51:47'),
(920, NULL, '40.77.167.7', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/login', '2025-08-12 12:51:48'),
(921, NULL, '124.222.142.44', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-12 16:28:14'),
(922, NULL, '124.222.142.44', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-12 16:28:19'),
(923, NULL, '117.33.163.216', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-12 22:28:30'),
(924, NULL, '117.33.163.216', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-12 22:28:31'),
(925, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 22:40:08'),
(926, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 22:40:08'),
(927, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 22:40:27'),
(928, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 22:40:27'),
(929, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 22:42:27'),
(930, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 22:42:27'),
(931, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 22:43:05'),
(932, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 22:43:05'),
(933, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 23:19:17'),
(934, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 23:19:17'),
(935, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 23:22:08'),
(936, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 23:22:08'),
(937, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 23:22:47'),
(938, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 23:22:47'),
(939, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-12 23:22:48'),
(940, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-12 23:22:48'),
(941, NULL, '119.45.20.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-13 01:29:54'),
(942, NULL, '119.45.20.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-13 01:29:58'),
(943, NULL, '4.227.36.56', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-13 02:38:35'),
(944, NULL, '4.227.36.56', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-13 02:38:35'),
(945, NULL, '4.227.36.56', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-13 02:44:16'),
(946, NULL, '4.227.36.56', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-13 02:44:17'),
(947, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 15:10:54'),
(948, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 15:10:54'),
(949, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 15:11:28'),
(950, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 15:11:28'),
(951, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 15:11:52'),
(952, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 15:11:52'),
(953, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 15:13:50'),
(954, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 15:13:50'),
(955, NULL, '43.130.3.122', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-13 15:41:58'),
(956, NULL, '43.130.3.122', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-13 15:42:00'),
(957, NULL, '4.227.36.54', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-13 16:05:50'),
(958, NULL, '4.227.36.54', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-13 16:05:50'),
(959, NULL, '34.71.92.243', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/', '2025-08-13 17:48:03'),
(960, NULL, '34.71.92.243', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/login', '2025-08-13 17:48:03'),
(961, NULL, '34.71.92.243', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/', '2025-08-13 17:48:04'),
(962, NULL, '34.71.92.243', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/login', '2025-08-13 17:48:04'),
(963, NULL, '93.158.90.65', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', '/irnaaz/', '2025-08-13 18:23:02'),
(964, NULL, '93.158.90.65', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', '/irnaaz/login', '2025-08-13 18:23:02'),
(965, NULL, '93.158.90.65', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', '/irnaaz/', '2025-08-13 18:23:02'),
(966, NULL, '93.158.90.73', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', '/irnaaz/login', '2025-08-13 18:23:02'),
(967, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 23:44:44'),
(968, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 23:44:44'),
(969, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 23:46:38'),
(970, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 23:46:38'),
(971, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 23:48:18'),
(972, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 23:48:18'),
(973, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-13 23:48:22'),
(974, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-13 23:48:22'),
(975, NULL, '43.135.144.81', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-14 00:15:25'),
(976, NULL, '43.135.144.81', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-14 00:15:27'),
(977, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 10:07:58'),
(978, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 10:07:58'),
(979, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 10:08:48'),
(980, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 10:08:48'),
(981, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 10:11:46'),
(982, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 10:11:46'),
(983, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 10:12:11'),
(984, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 10:12:11'),
(985, NULL, '83.150.213.133', 'Mozilla/5.0 (Windows NT 11.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', '/irnaaz/', '2025-08-14 16:27:45'),
(986, NULL, '83.150.213.133', 'Mozilla/5.0 (Windows NT 11.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', '/irnaaz/login', '2025-08-14 16:27:45'),
(987, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 20:37:20'),
(988, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 20:37:20'),
(989, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 20:37:50'),
(990, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 20:37:50'),
(991, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 20:40:00'),
(992, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 20:40:00'),
(993, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-14 20:40:55'),
(994, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-14 20:40:56'),
(995, NULL, '66.249.70.8', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/', '2025-08-14 21:50:02'),
(996, NULL, '66.249.70.6', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/login', '2025-08-14 21:50:02'),
(997, NULL, '170.106.72.178', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-14 22:50:32'),
(998, NULL, '170.106.72.178', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-14 22:50:33'),
(999, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 00:58:52'),
(1000, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 00:58:52'),
(1001, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 00:59:16'),
(1002, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 00:59:17'),
(1003, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 01:00:21'),
(1004, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 01:00:21'),
(1005, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 01:01:49'),
(1006, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 01:01:49'),
(1007, NULL, '36.111.67.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-15 06:22:50'),
(1008, NULL, '36.111.67.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-15 06:22:54'),
(1009, NULL, '66.249.70.8', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/', '2025-08-15 06:23:54'),
(1010, NULL, '66.249.70.6', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/login', '2025-08-15 06:23:54'),
(1011, NULL, '35.192.15.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-15 06:44:05'),
(1012, NULL, '35.192.15.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-15 06:44:05'),
(1013, NULL, '35.192.15.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-15 06:44:06'),
(1014, NULL, '35.192.15.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-15 06:44:06'),
(1015, NULL, '119.28.177.175', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-15 09:40:44'),
(1016, NULL, '119.28.177.175', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-15 09:40:46'),
(1017, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 09:53:48'),
(1018, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 09:53:48'),
(1019, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 09:54:24'),
(1020, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 09:54:24'),
(1021, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 09:55:15'),
(1022, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 09:55:15'),
(1023, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 09:55:30'),
(1024, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 09:55:31'),
(1025, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 12:39:45'),
(1026, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 12:39:45'),
(1027, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 12:40:34'),
(1028, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 12:40:35'),
(1029, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 12:41:27'),
(1030, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 12:41:27'),
(1031, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 12:41:52'),
(1032, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 12:41:52'),
(1033, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 13:21:27'),
(1034, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:21:27'),
(1035, NULL, '212.154.30.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 13:21:31'),
(1036, NULL, '212.154.30.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:21:32'),
(1037, NULL, '176.235.75.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-15 13:21:32'),
(1038, NULL, '176.235.75.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:21:32'),
(1039, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:22:04'),
(1040, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:22:04'),
(1041, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:22:33'),
(1042, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 13:22:33'),
(1043, NULL, '43.159.144.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-15 18:12:42'),
(1044, NULL, '43.159.144.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-15 18:12:44'),
(1045, NULL, '69.172.232.227', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6', '/irnaaz/', '2025-08-15 20:22:52'),
(1046, NULL, '69.172.232.227', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6', '/irnaaz/login', '2025-08-15 20:22:52'),
(1047, NULL, '88.235.168.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-15 22:35:48'),
(1048, NULL, '43.134.141.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-15 23:33:04'),
(1049, NULL, '43.134.141.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-15 23:33:05'),
(1050, NULL, '43.135.133.194', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 00:16:17'),
(1051, NULL, '43.135.133.194', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 00:16:19'),
(1052, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 00:29:35'),
(1053, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 00:29:35'),
(1054, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 00:30:50'),
(1055, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 00:30:50'),
(1056, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 00:30:55'),
(1057, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 00:30:55'),
(1058, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 00:32:19'),
(1059, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 00:32:19'),
(1060, NULL, '139.155.139.22', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 04:01:08'),
(1061, NULL, '139.155.139.22', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 04:01:12'),
(1062, NULL, '4.227.36.23', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-16 05:11:36'),
(1063, NULL, '4.227.36.23', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-16 05:11:36'),
(1064, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 06:36:45'),
(1065, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 06:36:45'),
(1066, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 06:37:49'),
(1067, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 06:37:49'),
(1068, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 06:39:04'),
(1069, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 06:39:04');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(1070, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 06:40:29'),
(1071, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 06:40:29'),
(1072, NULL, '36.41.75.167', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 07:07:41'),
(1073, NULL, '36.41.75.167', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 07:07:47'),
(1074, NULL, '43.167.232.38', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 13:01:38'),
(1075, NULL, '43.167.232.38', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 13:01:40'),
(1076, NULL, '43.131.45.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 13:20:29'),
(1077, NULL, '43.131.45.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 13:20:30'),
(1078, NULL, '36.41.75.167', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 13:22:55'),
(1079, NULL, '36.41.75.167', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 13:22:58'),
(1080, NULL, '54.36.148.49', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', '/irnaaz/', '2025-08-16 14:28:44'),
(1081, NULL, '54.36.148.49', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', '/irnaaz/login', '2025-08-16 14:28:45'),
(1082, NULL, '43.135.135.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 15:15:13'),
(1083, NULL, '43.135.135.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 15:15:18'),
(1084, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 15:40:22'),
(1085, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 15:40:23'),
(1086, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 15:42:27'),
(1087, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 15:42:27'),
(1088, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 15:43:52'),
(1089, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 15:43:52'),
(1090, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 15:44:02'),
(1091, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 15:44:02'),
(1092, NULL, '49.51.204.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 18:10:50'),
(1093, NULL, '49.51.204.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 18:10:52'),
(1094, NULL, '162.14.197.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 19:42:07'),
(1095, NULL, '162.14.197.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 19:42:10'),
(1096, NULL, '49.12.147.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-16 21:33:59'),
(1097, NULL, '49.12.147.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-16 21:34:04'),
(1098, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 21:50:47'),
(1099, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 21:50:48'),
(1100, NULL, '43.159.149.216', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-16 22:14:40'),
(1101, NULL, '43.159.149.216', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-16 22:14:41'),
(1102, NULL, '43.153.85.46', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 00:16:13'),
(1103, NULL, '43.153.85.46', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 00:16:16'),
(1104, NULL, '43.159.138.217', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 02:08:43'),
(1105, NULL, '43.159.138.217', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 02:08:45'),
(1106, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 02:52:40'),
(1107, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 02:52:40'),
(1108, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 02:55:02'),
(1109, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 02:55:03'),
(1110, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 02:55:28'),
(1111, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 02:55:28'),
(1112, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 02:55:28'),
(1113, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 02:55:28'),
(1114, NULL, '4.227.36.33', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-17 03:12:02'),
(1115, NULL, '4.227.36.33', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-17 03:12:02'),
(1116, NULL, '43.130.32.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 04:20:03'),
(1117, NULL, '43.130.32.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 04:20:05'),
(1118, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 04:44:18'),
(1119, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 04:44:19'),
(1120, NULL, '180.102.134.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 04:46:45'),
(1121, NULL, '180.102.134.69', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 04:46:47'),
(1122, NULL, '124.222.142.44', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 07:56:39'),
(1123, NULL, '124.222.142.44', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 07:56:41'),
(1124, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 08:20:30'),
(1125, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 08:20:30'),
(1126, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 08:20:35'),
(1127, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 08:20:35'),
(1128, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 08:20:50'),
(1129, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 08:20:50'),
(1130, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 08:21:56'),
(1131, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 08:21:56'),
(1132, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/', '2025-08-17 09:31:14'),
(1133, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:14'),
(1134, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/xmlrpc.php?rsd', '2025-08-17 09:31:14'),
(1135, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login', '2025-08-17 09:31:15'),
(1136, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/blog/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:15'),
(1137, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/web/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:15'),
(1138, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wordpress/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:16'),
(1139, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/website/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:16'),
(1140, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:16'),
(1141, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/news/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:17'),
(1142, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2020/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:17'),
(1143, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2019/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:18'),
(1144, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/shop/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:18'),
(1145, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp1/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:18'),
(1146, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/test/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:19'),
(1147, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp2/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:19'),
(1148, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/site/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:20'),
(1149, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/cms/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:20'),
(1150, NULL, '34.21.122.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/sito/wp-includes/wlwmanifest.xml', '2025-08-17 09:31:20'),
(1151, NULL, '223.244.35.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 14:14:32'),
(1152, NULL, '223.244.35.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 14:14:34'),
(1153, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 14:41:44'),
(1154, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 14:41:45'),
(1155, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 14:42:35'),
(1156, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 14:42:35'),
(1157, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 14:42:59'),
(1158, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 14:42:59'),
(1159, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-17 14:45:07'),
(1160, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-17 14:45:07'),
(1161, NULL, '43.135.135.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 15:12:53'),
(1162, NULL, '43.135.135.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 15:12:55'),
(1163, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/', '2025-08-17 15:20:45'),
(1164, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:45'),
(1165, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/xmlrpc.php?rsd', '2025-08-17 15:20:46'),
(1166, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login', '2025-08-17 15:20:46'),
(1167, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/blog/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:47'),
(1168, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/web/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:47'),
(1169, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wordpress/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:48'),
(1170, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/website/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:49'),
(1171, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:49'),
(1172, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/news/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:50'),
(1173, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2020/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:50'),
(1174, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2019/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:51'),
(1175, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/shop/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:52'),
(1176, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp1/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:52'),
(1177, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/test/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:53'),
(1178, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp2/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:53'),
(1179, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/site/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:54'),
(1180, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/cms/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:54'),
(1181, NULL, '34.55.126.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/sito/wp-includes/wlwmanifest.xml', '2025-08-17 15:20:55'),
(1182, NULL, '182.44.2.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 17:28:38'),
(1183, NULL, '182.44.2.148', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 17:28:47'),
(1184, NULL, '185.130.227.201', 'Mozilla/5.0 (Linux; Android 8.0.0; SAMSUNG SM-G930F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/12.1 Chrome/79.0.3945.136 Mobile Safari/537.36', '/irnaaz/', '2025-08-17 20:17:45'),
(1185, NULL, '185.130.227.201', 'Mozilla/5.0 (Linux; Android 8.0.0; SAMSUNG SM-G930F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/12.1 Chrome/79.0.3945.136 Mobile Safari/537.36', '/irnaaz/login', '2025-08-17 20:17:45'),
(1186, NULL, '43.157.98.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 22:07:41'),
(1187, NULL, '43.157.98.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 22:07:42'),
(1188, NULL, '156.248.81.235', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Vivaldi/5.3.2679.68', '/irnaaz/', '2025-08-17 22:09:35'),
(1189, NULL, '156.248.81.235', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Vivaldi/5.3.2679.68', '/irnaaz/login', '2025-08-17 22:09:36'),
(1190, NULL, '156.228.113.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1264.71', '/irnaaz/login', '2025-08-17 22:09:42'),
(1191, NULL, '156.228.113.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1264.71', '/irnaaz/login', '2025-08-17 22:09:42'),
(1192, NULL, '43.130.154.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-17 22:27:27'),
(1193, NULL, '43.130.154.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-17 22:27:28'),
(1194, NULL, '170.106.192.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 00:15:33'),
(1195, NULL, '170.106.192.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 00:15:36'),
(1196, NULL, '43.133.91.48', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 02:07:55'),
(1197, NULL, '43.133.91.48', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 02:07:57'),
(1198, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 02:43:39'),
(1199, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 02:43:39'),
(1200, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 02:43:59'),
(1201, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 02:43:59'),
(1202, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 02:44:42'),
(1203, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 02:44:42'),
(1204, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 02:45:17'),
(1205, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 02:45:17'),
(1206, NULL, '43.165.65.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 03:59:58'),
(1207, NULL, '43.165.65.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 03:59:59'),
(1208, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/', '2025-08-18 04:20:24'),
(1209, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:24'),
(1210, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/xmlrpc.php?rsd', '2025-08-18 04:20:25'),
(1211, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login', '2025-08-18 04:20:26'),
(1212, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/blog/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:26'),
(1213, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/web/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:27'),
(1214, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wordpress/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:28'),
(1215, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/website/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:29'),
(1216, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:30'),
(1217, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/news/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:31'),
(1218, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/2018/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:32'),
(1219, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/2019/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:33'),
(1220, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/shop/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:34'),
(1221, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp1/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:35'),
(1222, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/test/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:36'),
(1223, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/media/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:37'),
(1224, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp2/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:38'),
(1225, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/site/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:39'),
(1226, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/cms/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:40'),
(1227, NULL, '13.215.202.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/sito/wp-includes/wlwmanifest.xml', '2025-08-18 04:20:41'),
(1228, NULL, '43.153.10.13', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 04:21:33'),
(1229, NULL, '43.153.10.13', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 04:21:34'),
(1230, NULL, '180.190.216.129', 'Mozilla/5.0 (Windows NT 10.0; arm64) AppleWebKit/537.36 (KHTML, like Gecko) Safari/10.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 06:48:51'),
(1231, NULL, '180.190.216.129', 'Mozilla/5.0 (Windows NT 10.0; arm64) AppleWebKit/537.36 (KHTML, like Gecko) Safari/10.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 06:48:51'),
(1232, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/', '2025-08-18 08:29:49'),
(1233, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:49'),
(1234, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/xmlrpc.php?rsd', '2025-08-18 08:29:50'),
(1235, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login', '2025-08-18 08:29:50'),
(1236, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/blog/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:50'),
(1237, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/web/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:51'),
(1238, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wordpress/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:52'),
(1239, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/website/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:52'),
(1240, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:53'),
(1241, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/news/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:53'),
(1242, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2020/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:54'),
(1243, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/2019/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:54'),
(1244, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/shop/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:55'),
(1245, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp1/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:55'),
(1246, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/test/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:56'),
(1247, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/wp2/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:57'),
(1248, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/site/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:57'),
(1249, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/cms/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:58'),
(1250, NULL, '34.173.47.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', '/irnaaz/login/sito/wp-includes/wlwmanifest.xml', '2025-08-18 08:29:58'),
(1251, NULL, '43.166.128.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 09:28:33'),
(1252, NULL, '43.166.128.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 09:28:34'),
(1253, NULL, '170.106.192.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 09:46:59'),
(1254, NULL, '170.106.192.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 09:47:01'),
(1255, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 11:02:33'),
(1256, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 11:02:33'),
(1257, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 11:03:59'),
(1258, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 11:03:59'),
(1259, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 11:04:13'),
(1260, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 11:04:14'),
(1261, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 11:05:11'),
(1262, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 11:05:11'),
(1263, NULL, '101.42.117.179', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 11:54:53'),
(1264, NULL, '101.42.117.179', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 11:55:01'),
(1265, NULL, '101.32.52.164', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 14:22:20'),
(1266, NULL, '101.32.52.164', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 14:22:23'),
(1267, NULL, '43.157.147.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 14:39:43'),
(1268, NULL, '43.157.147.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 14:39:45'),
(1269, NULL, '86.104.252.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '/irnaaz/', '2025-08-18 17:39:18'),
(1270, NULL, '86.104.252.20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '/irnaaz/login', '2025-08-18 17:39:18'),
(1271, NULL, '162.62.213.165', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 18:09:16'),
(1272, NULL, '162.62.213.165', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 18:09:16'),
(1273, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 19:17:32'),
(1274, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 19:17:32'),
(1275, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 19:17:35'),
(1276, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 19:17:36'),
(1277, NULL, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 19:17:39'),
(1278, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 19:17:40'),
(1279, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-18 19:17:47'),
(1280, 1, '82.25.101.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-18 19:21:28'),
(1281, NULL, '49.12.147.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 19:58:44'),
(1282, NULL, '49.12.147.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 19:58:44'),
(1283, NULL, '159.223.146.201', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0', '/irnaaz/', '2025-08-18 20:25:07'),
(1284, NULL, '159.223.146.201', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0', '/irnaaz/login', '2025-08-18 20:25:07'),
(1285, NULL, '175.27.164.113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 21:22:00'),
(1286, NULL, '175.27.164.113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 21:22:05'),
(1287, NULL, '144.76.33.52', 'Mozilla/5.0 (compatible; BLEXBot/1.0; +https://help.seranking.com/en/blex-crawler)', '/irnaaz/', '2025-08-18 21:23:25'),
(1288, NULL, '144.76.33.52', 'Mozilla/5.0 (compatible; BLEXBot/1.0; +https://help.seranking.com/en/blex-crawler)', '/irnaaz/login', '2025-08-18 21:23:25'),
(1289, NULL, '144.76.33.52', 'Mozilla/5.0 (compatible; BLEXBot/1.0; +https://help.seranking.com/en/blex-crawler)', '/irnaaz/', '2025-08-18 21:23:26'),
(1290, NULL, '144.76.33.52', 'Mozilla/5.0 (compatible; BLEXBot/1.0; +https://help.seranking.com/en/blex-crawler)', '/irnaaz/login', '2025-08-18 21:23:26'),
(1291, NULL, '43.157.180.116', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-18 22:38:05'),
(1292, NULL, '43.157.180.116', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-18 22:38:06'),
(1293, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 23:54:16'),
(1294, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 23:54:17'),
(1295, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 23:54:21'),
(1296, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 23:54:21'),
(1297, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 23:54:31'),
(1298, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 23:54:31'),
(1299, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-18 23:54:41'),
(1300, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-18 23:54:41'),
(1301, NULL, '43.143.248.236', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 00:23:01'),
(1302, NULL, '43.143.248.236', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 00:23:13'),
(1303, NULL, '170.106.197.109', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 02:05:50'),
(1304, NULL, '170.106.197.109', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 02:05:51'),
(1305, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/', '2025-08-19 04:30:43'),
(1306, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:43'),
(1307, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/xmlrpc.php?rsd', '2025-08-19 04:30:43'),
(1308, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login', '2025-08-19 04:30:43'),
(1309, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/blog/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1310, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/web/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1311, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wordpress/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1312, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/website/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1313, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1314, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/news/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44'),
(1315, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/2018/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:44');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(1316, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/2019/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:45'),
(1317, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/shop/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:45'),
(1318, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp1/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:45'),
(1319, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/test/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:45'),
(1320, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/media/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:45'),
(1321, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/wp2/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:46'),
(1322, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/site/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:46'),
(1323, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/cms/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:46'),
(1324, NULL, '185.104.184.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', '/irnaaz/login/sito/wp-includes/wlwmanifest.xml', '2025-08-19 04:30:46'),
(1325, NULL, '43.130.16.140', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:34:22'),
(1326, NULL, '43.130.16.140', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:34:23'),
(1327, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:05'),
(1328, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:05'),
(1329, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:08'),
(1330, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:08'),
(1331, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:09'),
(1332, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:10'),
(1333, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:11'),
(1334, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:12'),
(1335, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:12'),
(1336, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:12'),
(1337, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:14'),
(1338, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:14'),
(1339, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:15'),
(1340, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:15'),
(1341, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:16'),
(1342, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:16'),
(1343, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:16'),
(1344, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:17'),
(1345, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:18'),
(1346, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:18'),
(1347, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:20'),
(1348, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:21'),
(1349, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:22'),
(1350, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:22'),
(1351, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:34'),
(1352, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:35'),
(1353, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:37'),
(1354, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:37'),
(1355, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:38'),
(1356, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:38'),
(1357, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:40'),
(1358, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:40'),
(1359, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:42'),
(1360, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:43'),
(1361, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 04:43:44'),
(1362, NULL, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 04:43:44'),
(1363, NULL, '60.188.57.0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 06:33:43'),
(1364, NULL, '60.188.57.0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 06:33:48'),
(1365, NULL, '182.44.8.254', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 09:45:33'),
(1366, NULL, '89.22.101.69', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '/irnaaz/', '2025-08-19 10:32:34'),
(1367, NULL, '89.22.101.69', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '/irnaaz/login', '2025-08-19 10:32:34'),
(1368, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 11:35:43'),
(1369, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 11:35:43'),
(1370, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 11:36:14'),
(1371, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 11:36:15'),
(1372, NULL, '170.106.180.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 13:55:12'),
(1373, NULL, '170.106.180.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 13:55:13'),
(1374, NULL, '45.55.207.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 14:00:24'),
(1375, NULL, '43.166.253.94', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 14:12:05'),
(1376, NULL, '43.166.253.94', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 14:12:06'),
(1377, NULL, '170.106.180.246', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 15:12:07'),
(1378, NULL, '170.106.180.246', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 15:12:09'),
(1379, NULL, '159.196.132.126', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/', '2025-08-19 16:20:01'),
(1380, NULL, '159.196.132.126', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '/irnaaz/login', '2025-08-19 16:20:01'),
(1381, NULL, '5.133.192.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 18:02:13'),
(1382, NULL, '43.165.65.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 18:09:00'),
(1383, NULL, '43.165.65.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 18:09:03'),
(1384, NULL, '199.45.155.96', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', '/irnaaz/', '2025-08-19 20:54:49'),
(1385, NULL, '199.45.155.96', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', '/irnaaz/login', '2025-08-19 20:54:51'),
(1386, NULL, '43.155.26.193', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 21:40:33'),
(1387, NULL, '43.155.26.193', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 21:40:35'),
(1388, NULL, '43.155.188.157', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 21:54:31'),
(1389, NULL, '43.155.188.157', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 21:54:33'),
(1390, NULL, '49.232.151.112', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-19 22:01:36'),
(1391, NULL, '49.232.151.112', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-19 22:01:43'),
(1392, NULL, '109.199.118.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', '/irnaaz/', '2025-08-19 22:46:39'),
(1393, NULL, '109.199.118.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', '/irnaaz/login', '2025-08-19 22:46:39'),
(1394, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 22:58:14'),
(1395, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 22:58:15'),
(1396, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 22:59:29'),
(1397, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 22:59:30'),
(1398, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:02:23'),
(1399, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:02:23'),
(1400, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:02:38'),
(1401, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:02:38'),
(1402, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:42:57'),
(1403, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:42:57'),
(1404, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:44:11'),
(1405, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:44:11'),
(1406, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:46:01'),
(1407, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:46:01'),
(1408, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-19 23:46:06'),
(1409, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-19 23:46:06'),
(1410, NULL, '93.158.90.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', '/irnaaz/', '2025-08-20 00:07:36'),
(1411, NULL, '93.158.90.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', '/irnaaz/login', '2025-08-20 00:07:36'),
(1412, NULL, '93.158.90.69', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', '/irnaaz/', '2025-08-20 00:07:37'),
(1413, NULL, '93.158.90.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', '/irnaaz/login', '2025-08-20 00:07:37'),
(1414, NULL, '43.153.123.4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 00:15:42'),
(1415, NULL, '43.153.123.4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 00:15:43'),
(1416, NULL, '43.130.12.43', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 02:08:53'),
(1417, NULL, '43.130.12.43', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 02:08:55'),
(1418, NULL, '43.164.197.224', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 03:32:53'),
(1419, NULL, '43.164.197.224', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 03:32:54'),
(1420, NULL, '182.44.12.37', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 07:17:20'),
(1421, NULL, '157.55.39.225', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/', '2025-08-20 07:52:45'),
(1422, NULL, '157.55.39.225', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', '/irnaaz/login', '2025-08-20 07:52:45'),
(1423, NULL, '43.153.67.21', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 08:17:03'),
(1424, NULL, '43.153.67.21', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 08:17:07'),
(1425, NULL, '43.157.181.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 08:40:18'),
(1426, NULL, '43.157.181.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 08:40:20'),
(1427, NULL, '34.220.79.236', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/', '2025-08-20 11:06:37'),
(1428, NULL, '34.220.79.236', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', '/irnaaz/login', '2025-08-20 11:06:37'),
(1429, NULL, '170.106.82.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 13:23:43'),
(1430, NULL, '170.106.82.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 13:23:44'),
(1431, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-20 13:43:16'),
(1432, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-20 13:43:16'),
(1433, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-20 13:43:57'),
(1434, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-20 13:43:57'),
(1435, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-20 13:45:05'),
(1436, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-20 13:45:05'),
(1437, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-20 13:47:14'),
(1438, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-20 13:47:14'),
(1439, NULL, '43.153.86.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 15:12:40'),
(1440, NULL, '43.153.86.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 15:12:43'),
(1441, NULL, '43.157.188.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 18:12:39'),
(1442, NULL, '43.157.188.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 18:12:41'),
(1443, NULL, '43.155.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 21:53:42'),
(1444, NULL, '43.155.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 21:53:43'),
(1445, NULL, '43.134.141.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 22:14:45'),
(1446, NULL, '43.134.141.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 22:14:47'),
(1447, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-20 23:04:35'),
(1448, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-20 23:04:40'),
(1449, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 01:59:14'),
(1450, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 01:59:14'),
(1451, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 01:59:35'),
(1452, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 01:59:35'),
(1453, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:00:55'),
(1454, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:00:55'),
(1455, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:02:17'),
(1456, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:02:17'),
(1457, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:02:53'),
(1458, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:02:53'),
(1459, NULL, '94.191.43.82', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 02:07:15'),
(1460, NULL, '94.191.43.82', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 02:07:17'),
(1461, NULL, '43.166.250.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 02:09:01'),
(1462, NULL, '43.166.250.187', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 02:09:03'),
(1463, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:33:02'),
(1464, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:33:02'),
(1465, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:34:12'),
(1466, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:34:12'),
(1467, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:36:51'),
(1468, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:36:51'),
(1469, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 02:37:06'),
(1470, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 02:37:06'),
(1471, NULL, '43.164.196.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 05:28:11'),
(1472, NULL, '43.164.196.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 05:28:17'),
(1473, NULL, '43.153.79.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 05:56:17'),
(1474, NULL, '43.153.79.218', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 05:56:19'),
(1475, NULL, '34.61.178.24', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-21 07:32:00'),
(1476, NULL, '34.61.178.24', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-21 07:32:00'),
(1477, NULL, '34.61.178.24', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-21 07:32:00'),
(1478, NULL, '34.61.178.24', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-21 07:32:01'),
(1479, NULL, '182.40.104.255', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 08:32:14'),
(1480, NULL, '43.157.147.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 10:58:07'),
(1481, NULL, '43.157.147.3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 10:58:08'),
(1482, NULL, '34.69.212.95', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-21 10:58:29'),
(1483, NULL, '34.69.212.95', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-21 10:58:29'),
(1484, NULL, '34.69.212.95', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-21 10:58:30'),
(1485, NULL, '34.69.212.95', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-21 10:58:30'),
(1486, NULL, '43.164.197.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 11:19:45'),
(1487, NULL, '43.164.197.209', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 11:19:46'),
(1488, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 11:36:18'),
(1489, NULL, '124.221.245.78', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 11:36:19'),
(1490, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 12:24:08'),
(1491, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 12:24:08'),
(1492, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 12:24:13'),
(1493, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 12:24:13'),
(1494, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 12:24:18'),
(1495, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 12:24:19'),
(1496, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 12:24:23'),
(1497, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 12:24:23'),
(1498, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 14:03:15'),
(1499, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 14:03:15'),
(1500, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 14:03:59'),
(1501, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 14:04:00'),
(1502, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 14:05:01'),
(1503, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 14:05:01'),
(1504, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 14:05:18'),
(1505, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 14:05:18'),
(1506, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:28'),
(1507, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:28'),
(1508, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:28'),
(1509, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:28'),
(1510, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:28'),
(1511, NULL, '47.237.101.224', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:28'),
(1512, NULL, '47.237.101.224', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/irnaaz/', '2025-08-21 14:30:29'),
(1513, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:29'),
(1514, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:29'),
(1515, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/', '2025-08-21 14:30:29'),
(1516, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:29'),
(1517, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:29'),
(1518, NULL, '47.237.84.71', 'fasthttp', '/irnaaz/login', '2025-08-21 14:30:29'),
(1519, NULL, '47.237.84.71', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/irnaaz/', '2025-08-21 14:30:30'),
(1520, NULL, '47.237.101.224', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/irnaaz/login', '2025-08-21 14:30:34'),
(1521, NULL, '47.237.84.71', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/irnaaz/login', '2025-08-21 14:30:35'),
(1522, NULL, '222.79.103.59', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 14:55:23'),
(1523, NULL, '222.79.103.59', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 14:55:27'),
(1524, NULL, '43.135.140.225', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 15:11:20'),
(1525, NULL, '43.135.140.225', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 15:11:21'),
(1526, NULL, '4.227.36.19', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-21 15:13:43'),
(1527, NULL, '4.227.36.19', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-21 15:13:43'),
(1528, NULL, '43.130.3.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 15:56:33'),
(1529, NULL, '43.130.3.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 15:56:34'),
(1530, NULL, '4.227.36.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-21 16:07:28'),
(1531, NULL, '4.227.36.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-21 16:07:28'),
(1532, NULL, '43.157.179.227', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 16:13:08'),
(1533, NULL, '43.157.179.227', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 16:13:10'),
(1534, NULL, '4.227.36.19', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-21 17:10:45'),
(1535, NULL, '4.227.36.19', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-21 17:10:46'),
(1536, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 18:06:27'),
(1537, NULL, '121.4.97.180', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 18:06:29'),
(1538, NULL, '119.28.177.175', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 18:22:39'),
(1539, NULL, '119.28.177.175', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 18:22:41'),
(1540, NULL, '45.249.247.26', 'Mozilla/5.0 (Android 13; Mobile; rv:128.0.1) Gecko/128.0.1 Firefox/128.0.1', '/irnaaz/', '2025-08-21 19:21:21'),
(1541, NULL, '45.249.247.26', 'Mozilla/5.0 (Android 13; Mobile; rv:128.0.1) Gecko/128.0.1 Firefox/128.0.1', '/irnaaz/login', '2025-08-21 19:21:22'),
(1542, NULL, '45.249.247.26', 'Mozilla/5.0 (Android 12; Mobile; rv:115.6.0) Gecko/115.6.0 Firefox/115.6.0', '/irnaaz/', '2025-08-21 19:21:22'),
(1543, NULL, '45.249.247.26', 'Mozilla/5.0 (Android 12; Mobile; rv:115.6.0) Gecko/115.6.0 Firefox/115.6.0', '/irnaaz/login', '2025-08-21 19:21:22'),
(1544, NULL, '45.249.247.26', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', '/irnaaz/', '2025-08-21 19:21:23'),
(1545, NULL, '45.249.247.26', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', '/irnaaz/login', '2025-08-21 19:21:23'),
(1546, NULL, '45.249.247.26', 'curl/7.4.0', '/irnaaz/', '2025-08-21 19:21:24'),
(1547, NULL, '45.249.247.26', 'curl/7.4.0', '/irnaaz/login', '2025-08-21 19:21:24'),
(1548, NULL, '45.249.247.26', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/15.0 EdgiOS/130.0.2849.49 Mobile/15E148 Safari/537.36', '/irnaaz/', '2025-08-21 19:21:24'),
(1549, NULL, '45.249.247.26', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/15.0 EdgiOS/130.0.2849.49 Mobile/15E148 Safari/537.36', '/irnaaz/login', '2025-08-21 19:21:25'),
(1550, NULL, '45.249.247.26', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/15.0 EdgiOS/130.0.2849.49 Mobile/15E148 Safari/537.36', '/irnaaz/', '2025-08-21 19:21:25'),
(1551, NULL, '45.249.247.26', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/15.0 EdgiOS/130.0.2849.49 Mobile/15E148 Safari/537.36', '/irnaaz/login', '2025-08-21 19:21:25'),
(1552, NULL, '132.232.203.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-21 21:08:41'),
(1553, NULL, '132.232.203.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-21 21:08:49'),
(1554, NULL, '4.227.36.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-21 21:14:23'),
(1555, NULL, '4.227.36.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-21 21:14:23'),
(1556, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 21:22:39'),
(1557, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 21:22:39'),
(1558, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 21:22:44'),
(1559, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 21:22:44'),
(1560, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 21:24:49'),
(1561, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 21:24:49'),
(1562, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-21 21:25:30'),
(1563, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-21 21:25:30'),
(1564, NULL, '82.156.68.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 00:07:18'),
(1565, NULL, '82.156.68.74', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 00:07:20'),
(1566, NULL, '43.157.156.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 00:16:04'),
(1567, NULL, '43.157.156.190', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 00:16:06'),
(1568, NULL, '4.227.36.46', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-22 00:20:10'),
(1569, NULL, '4.227.36.46', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-22 00:20:10'),
(1570, NULL, '49.51.195.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 01:09:24'),
(1571, NULL, '49.51.195.195', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 01:09:25'),
(1572, NULL, '213.180.203.220', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-08-22 01:17:51'),
(1573, NULL, '213.180.203.220', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-08-22 01:17:51'),
(1574, NULL, '5.255.231.155', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-08-22 01:17:53'),
(1575, NULL, '213.180.203.76', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-08-22 01:17:54'),
(1576, NULL, '213.180.203.68', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/', '2025-08-22 01:28:14'),
(1577, NULL, '213.180.203.142', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', '/irnaaz/login', '2025-08-22 01:28:14');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(1578, NULL, '43.165.67.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 01:47:02'),
(1579, NULL, '43.165.67.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 01:47:03'),
(1580, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 04:23:56'),
(1581, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 04:23:56'),
(1582, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 04:25:56'),
(1583, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 04:25:56'),
(1584, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 04:26:11'),
(1585, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 04:26:11'),
(1586, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 04:28:00'),
(1587, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 04:28:00'),
(1588, NULL, '66.249.70.7', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/', '2025-08-22 06:39:17'),
(1589, NULL, '66.249.70.6', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', '/irnaaz/login', '2025-08-22 06:39:17'),
(1590, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/', '2025-08-22 06:51:18'),
(1591, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/login', '2025-08-22 06:51:18'),
(1592, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/', '2025-08-22 06:51:18'),
(1593, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/login', '2025-08-22 06:51:19'),
(1594, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/', '2025-08-22 06:51:19'),
(1595, NULL, '84.246.85.11', '2ip bot/1.1 (+http://2ip.io)', '/irnaaz/login', '2025-08-22 06:51:19'),
(1596, NULL, '4.227.36.54', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-22 08:31:04'),
(1597, NULL, '4.227.36.54', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-22 08:31:04'),
(1598, NULL, '104.154.156.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-22 08:49:47'),
(1599, NULL, '104.154.156.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-22 08:49:47'),
(1600, NULL, '104.154.156.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/', '2025-08-22 08:49:48'),
(1601, NULL, '104.154.156.118', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', '/irnaaz/login', '2025-08-22 08:49:48'),
(1602, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 09:01:00'),
(1603, NULL, '43.165.69.68', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 09:01:01'),
(1604, NULL, '124.156.179.141', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 09:28:25'),
(1605, NULL, '124.156.179.141', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 09:28:27'),
(1606, NULL, '104.28.231.189', 'Mozilla/5.0 (Windows NT 6.3; x86) AppleWebKit/537.36 (KHTML, like Gecko) Opera/60.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 09:32:07'),
(1607, NULL, '104.28.231.189', 'Mozilla/5.0 (Windows NT 6.3; x86) AppleWebKit/537.36 (KHTML, like Gecko) Opera/60.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 09:32:07'),
(1608, NULL, '23.111.114.116', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.0 Mobile/14G60 Safari/602.1', '/irnaaz/', '2025-08-22 10:16:43'),
(1609, NULL, '23.111.114.116', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.0 Mobile/14G60 Safari/602.1', '/irnaaz/login', '2025-08-22 10:16:43'),
(1610, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 12:23:37'),
(1611, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 12:23:38'),
(1612, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 12:26:08'),
(1613, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 12:26:08'),
(1614, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 12:26:12'),
(1615, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 12:26:12'),
(1616, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 12:27:13'),
(1617, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 12:27:13'),
(1618, NULL, '43.165.135.242', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 15:10:03'),
(1619, NULL, '43.165.135.242', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 15:10:06'),
(1620, NULL, '43.158.91.71', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 15:10:45'),
(1621, NULL, '43.158.91.71', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 15:10:46'),
(1622, NULL, '43.155.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 15:31:13'),
(1623, NULL, '43.155.27.244', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 15:31:15'),
(1624, NULL, '180.110.203.108', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 15:52:21'),
(1625, NULL, '23.111.114.116', 'Mozilla/5.0 (Linux; Android 9; Redmi 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36', '/irnaaz/', '2025-08-22 16:27:52'),
(1626, NULL, '23.111.114.116', 'Mozilla/5.0 (Linux; Android 9; Redmi 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Mobile Safari/537.36', '/irnaaz/login', '2025-08-22 16:27:52'),
(1627, NULL, '51.222.253.14', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', '/irnaaz/', '2025-08-22 18:46:39'),
(1628, NULL, '51.222.253.14', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', '/irnaaz/login', '2025-08-22 18:46:39'),
(1629, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 20:24:34'),
(1630, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 20:24:35'),
(1631, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 20:24:49'),
(1632, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 20:24:49'),
(1633, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 20:25:14'),
(1634, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 20:25:15'),
(1635, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 20:26:19'),
(1636, NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 20:26:19'),
(1637, NULL, '185.130.227.201', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4469.0 Mobile Safari/537.36', '/irnaaz/', '2025-08-22 20:32:22'),
(1638, NULL, '185.130.227.201', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4469.0 Mobile Safari/537.36', '/irnaaz/login', '2025-08-22 20:32:22'),
(1639, NULL, '175.27.164.113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 21:57:42'),
(1640, NULL, '175.27.164.113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 21:57:45'),
(1641, NULL, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:35:43'),
(1642, NULL, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 22:35:44'),
(1643, NULL, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 22:35:51'),
(1644, NULL, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 22:35:51'),
(1645, NULL, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/login', '2025-08-22 22:35:57'),
(1646, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:35:57'),
(1647, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:37:56'),
(1648, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:39:00'),
(1649, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:40:12'),
(1650, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:41:52'),
(1651, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 22:42:57'),
(1652, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 22:43:16'),
(1653, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 22:43:18'),
(1654, NULL, '54.244.182.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/', '2025-08-22 22:48:44'),
(1655, NULL, '54.244.182.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/login', '2025-08-22 22:48:44'),
(1656, NULL, '54.244.182.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/', '2025-08-22 22:48:45'),
(1657, NULL, '54.244.182.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', '/irnaaz/login', '2025-08-22 22:48:45'),
(1658, NULL, '43.164.197.177', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 22:55:31'),
(1659, NULL, '43.164.197.177', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 22:55:32'),
(1660, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:03:27'),
(1661, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:09:27'),
(1662, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:12:52'),
(1663, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:13:05'),
(1664, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:13:09'),
(1665, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:13:13'),
(1666, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:13:14'),
(1667, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:13:17'),
(1668, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:13:19'),
(1669, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:13:22'),
(1670, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:13:26'),
(1671, NULL, '43.130.14.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-22 23:15:41'),
(1672, NULL, '43.130.14.245', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-22 23:15:43'),
(1673, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:16:09'),
(1674, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:17:29'),
(1675, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:17:34'),
(1676, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:17:46'),
(1677, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:18:10'),
(1678, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-08-22 23:18:14'),
(1679, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-08-22 23:18:18'),
(1680, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-08-22 23:18:20'),
(1681, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/admins', '2025-08-22 23:19:39'),
(1682, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:19:42'),
(1683, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:19:46'),
(1684, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:20:15'),
(1685, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:20:29'),
(1686, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:21:54'),
(1687, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/suitcases', '2025-08-22 23:22:46'),
(1688, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/suitcases/create', '2025-08-22 23:22:48'),
(1689, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/financial/wallets/product', '2025-08-22 23:22:53'),
(1690, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/financial/assign-credit?user_id=3', '2025-08-22 23:22:57'),
(1691, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/financial/receipts/product', '2025-08-22 23:23:03'),
(1692, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/financial/receipts/shipping', '2025-08-22 23:23:07'),
(1693, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/financial/debtors', '2025-08-22 23:23:11'),
(1694, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/shipping-rates', '2025-08-22 23:23:22'),
(1695, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-22 23:23:25'),
(1696, NULL, '4.227.36.84', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-22 23:23:28'),
(1697, NULL, '4.227.36.84', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-22 23:23:29'),
(1698, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:23:33'),
(1699, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:24:36'),
(1700, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:24:47'),
(1701, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-22 23:26:11'),
(1702, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:26:15'),
(1703, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-22 23:26:17'),
(1704, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:26:58'),
(1705, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/cancelled-orders?status_id=12', '2025-08-22 23:28:04'),
(1706, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-08-22 23:28:10'),
(1707, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/suspended-orders', '2025-08-22 23:29:01'),
(1708, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:29:06'),
(1709, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:32:22'),
(1710, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show/1', '2025-08-22 23:32:26'),
(1711, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show/1', '2025-08-22 23:32:42'),
(1712, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show/1', '2025-08-22 23:34:54'),
(1713, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-22 23:34:59'),
(1714, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:35:05'),
(1715, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-22 23:35:15'),
(1716, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-22 23:35:19'),
(1717, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:35:29'),
(1718, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-22 23:38:01'),
(1719, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:38:05'),
(1720, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:38:11'),
(1721, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:38:15'),
(1722, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:41:30'),
(1723, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:42:56'),
(1724, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:43:41'),
(1725, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:54:02'),
(1726, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:54:15'),
(1727, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:56:07'),
(1728, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/order-categories', '2025-08-22 23:56:12'),
(1729, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/order-categories/create', '2025-08-22 23:56:14'),
(1730, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/order-categories/store', '2025-08-22 23:56:24'),
(1731, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/order-categories', '2025-08-22 23:56:24'),
(1732, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:56:29'),
(1733, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-22 23:56:34'),
(1734, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-22 23:57:16'),
(1735, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/create', '2025-08-23 00:01:31'),
(1736, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:01:44'),
(1737, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders?status_id=2', '2025-08-23 00:01:53'),
(1738, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:01:56'),
(1739, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/order-statuses', '2025-08-23 00:02:04'),
(1740, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:02:13'),
(1741, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:04:48'),
(1742, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:04:59'),
(1743, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:05:03'),
(1744, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:05:05'),
(1745, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 00:07:11'),
(1746, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 00:07:23'),
(1747, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 00:07:41'),
(1748, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-23 00:09:04'),
(1749, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:09:19'),
(1750, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:09:20'),
(1751, NULL, '43.153.12.58', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-23 00:16:49'),
(1752, NULL, '43.153.12.58', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-23 00:16:51'),
(1753, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:18:12'),
(1754, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:18:19'),
(1755, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:18:23'),
(1756, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 00:19:14'),
(1757, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 00:19:14'),
(1758, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:19:17'),
(1759, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:19:21'),
(1760, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:19:23'),
(1761, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:19:38'),
(1762, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:19:40'),
(1763, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:19:53'),
(1764, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/announcements/user', '2025-08-23 00:25:42'),
(1765, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/profile', '2025-08-23 00:25:48'),
(1766, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:25:52'),
(1767, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:28:06'),
(1768, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:28:10'),
(1769, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 00:28:18'),
(1770, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 00:28:19'),
(1771, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:28:30'),
(1772, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:28:34'),
(1773, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:28:40'),
(1774, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 00:28:55'),
(1775, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites/store', '2025-08-23 00:29:14'),
(1776, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 00:29:47'),
(1777, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:45:08'),
(1778, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:45:12'),
(1779, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:45:19'),
(1780, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:45:30'),
(1781, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 00:45:43'),
(1782, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites/store', '2025-08-23 00:46:02'),
(1783, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 00:46:02'),
(1784, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:46:51'),
(1785, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 00:48:35'),
(1786, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 00:48:36'),
(1787, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:48:42'),
(1788, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:48:46'),
(1789, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 00:48:54'),
(1790, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 00:48:54'),
(1791, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-23 00:49:57'),
(1792, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-23 00:50:37'),
(1793, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 00:50:41'),
(1794, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 00:50:42'),
(1795, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:50:48'),
(1796, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 00:50:52'),
(1797, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 00:51:25'),
(1798, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 00:52:42'),
(1799, NULL, '4.227.36.68', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/', '2025-08-23 00:55:45'),
(1800, NULL, '4.227.36.68', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', '/irnaaz/login', '2025-08-23 00:55:46'),
(1801, NULL, '122.51.104.231', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/', '2025-08-23 00:56:08'),
(1802, NULL, '122.51.104.231', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', '/irnaaz/login', '2025-08-23 00:56:12'),
(1803, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:01:56'),
(1804, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:08:43'),
(1805, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:08:47'),
(1806, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 01:08:51'),
(1807, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:08:51'),
(1808, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:08:53'),
(1809, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 01:08:53'),
(1810, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 01:09:50'),
(1811, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:09:52'),
(1812, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:09:56'),
(1813, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:10:07'),
(1814, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:10:34'),
(1815, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 01:10:37'),
(1816, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:10:37'),
(1817, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:10:52'),
(1818, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:10:56'),
(1819, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/settings/sms', '2025-08-23 01:11:00'),
(1820, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:11:11'),
(1821, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:11:16'),
(1822, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:11:30'),
(1823, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:11:32'),
(1824, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:11:35'),
(1825, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/https://nilayteam.ir/irnaaz/orders', '2025-08-23 01:11:36'),
(1826, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:11:39'),
(1827, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:12:56'),
(1828, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:13:00'),
(1829, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:16:30'),
(1830, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:16:38'),
(1831, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:16:38'),
(1832, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:16:42'),
(1833, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:16:43'),
(1834, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 01:16:49'),
(1835, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:16:55'),
(1836, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:17:02'),
(1837, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:17:06'),
(1838, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/', '2025-08-23 01:17:19'),
(1839, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:17:24'),
(1840, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:17:26'),
(1841, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/', '2025-08-23 01:25:20'),
(1842, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:25:27');
INSERT INTO `visitor_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `request_uri`, `timestamp`) VALUES
(1843, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/editSite?id=1', '2025-08-23 01:25:32'),
(1844, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/updateSite', '2025-08-23 01:25:50'),
(1845, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/constants/sites', '2025-08-23 01:25:50'),
(1846, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:25:57'),
(1847, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:26:07'),
(1848, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:26:08'),
(1849, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update-status', '2025-08-23 01:26:11'),
(1850, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:26:12'),
(1851, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 01:26:14'),
(1852, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/show?id=1', '2025-08-23 01:26:14'),
(1853, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:26:23'),
(1854, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/update', '2025-08-23 01:27:11'),
(1855, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:27:11'),
(1856, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders', '2025-08-23 01:27:17'),
(1857, 1, '185.206.162.167', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '/irnaaz/orders/edit?id=1', '2025-08-23 01:27:22'),
(1858, NULL, '4.43.184.114', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50728)', '/irnaaz/', '2025-08-23 01:32:35'),
(1859, NULL, '4.43.184.114', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50728)', '/irnaaz/login', '2025-08-23 01:32:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `announcements_author_id_foreign` (`author_id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `blog_posts_category_id_foreign` (`category_id`),
  ADD KEY `blog_posts_author_id_foreign` (`author_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `images_uploader_id_foreign` (`uploader_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menus_group_id_foreign` (`group_id`),
  ADD KEY `menus_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `menu_groups`
--
ALTER TABLE `menu_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `suitcase_id` (`suitcase_id`),
  ADD KEY `assigned_to_user_id` (`assigned_to_user_id`),
  ADD KEY `fk_order_category` (`category_id`);

--
-- Indexes for table `order_categories`
--
ALTER TABLE `order_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `page_slug` (`page_slug`);

--
-- Indexes for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_receipts_user_id_foreign` (`user_id`),
  ADD KEY `payment_receipts_reviewed_by_foreign` (`reviewed_by`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_key` (`permission_key`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_key` (`role_key`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `role_permissions_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `shipping_rates`
--
ALTER TABLE `shipping_rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `source_sites`
--
ALTER TABLE `source_sites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suitcases`
--
ALTER TABLE `suitcases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suitcase_code` (`suitcase_code`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `ticket_categories`
--
ALTER TABLE `ticket_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_announcements`
--
ALTER TABLE `user_announcements`
  ADD PRIMARY KEY (`user_id`,`announcement_id`),
  ADD KEY `user_announcements_announcement_id_foreign` (`announcement_id`);

--
-- Indexes for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visitor_logs_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu_groups`
--
ALTER TABLE `menu_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_categories`
--
ALTER TABLE `order_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `shipping_rates`
--
ALTER TABLE `shipping_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sites`
--
ALTER TABLE `sites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `source_sites`
--
ALTER TABLE `source_sites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `suitcases`
--
ALTER TABLE `suitcases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket_categories`
--
ALTER TABLE `ticket_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1860;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_posts_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `menu_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `menus_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_category` FOREIGN KEY (`category_id`) REFERENCES `order_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`suitcase_id`) REFERENCES `suitcases` (`id`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`assigned_to_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD CONSTRAINT `payment_receipts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_receipts_ibfk_2` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `suitcases`
--
ALTER TABLE `suitcases`
  ADD CONSTRAINT `suitcases_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `ticket_categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD CONSTRAINT `ticket_replies_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_replies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_announcements`
--
ALTER TABLE `user_announcements`
  ADD CONSTRAINT `user_announcements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_announcements_ibfk_2` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD CONSTRAINT `visitor_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
