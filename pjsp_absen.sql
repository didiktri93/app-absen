-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for pjsp_absen
CREATE DATABASE IF NOT EXISTS `pjsp_absen` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pjsp_absen`;

-- Dumping structure for table pjsp_absen.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;

-- Dumping structure for table pjsp_absen.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.migrations: ~11 rows (approximately)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2024_10_21_023333_create_kantors_table', 2),
	(6, '2024_10_21_025524_create_shifts_table', 3),
	(7, '2024_10_21_031243_create_jadwals_table', 4),
	(8, '2024_10_21_032759_create_kehadirans_table', 4),
	(10, '2024_10_21_075038_create_permission_tables', 5),
	(11, '2024_10_22_161620_create_cutis_table', 6),
	(12, '2023_06_07_000001_create_pulse_tables', 7);

-- Dumping structure for table pjsp_absen.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.model_has_permissions: ~0 rows (approximately)
DELETE FROM `model_has_permissions`;

-- Dumping structure for table pjsp_absen.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.model_has_roles: ~2 rows (approximately)
DELETE FROM `model_has_roles`;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(2, 'App\\Models\\User', 2);

-- Dumping structure for table pjsp_absen.m_kantor
CREATE TABLE IF NOT EXISTS `m_kantor` (
  `kntr_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_kntr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` text COLLATE utf8mb4_unicode_ci,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `radius` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kntr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.m_kantor: ~1 rows (approximately)
DELETE FROM `m_kantor`;
INSERT INTO `m_kantor` (`kntr_id`, `nama_kntr`, `location`, `latitude`, `longitude`, `radius`, `created_at`, `updated_at`, `deleted_at`) VALUES
	('6716007bba8cd', 'Kantor PJSP', '{"lat":-7.1314044477206,"lng":112.09080170835}', -7.1314044477206, 112.09080170835, 1000, '2024-10-21 00:19:23', '2024-10-21 21:58:40', NULL);

-- Dumping structure for table pjsp_absen.m_shift
CREATE TABLE IF NOT EXISTS `m_shift` (
  `shift_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_shift` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.m_shift: ~1 rows (approximately)
DELETE FROM `m_shift`;
INSERT INTO `m_shift` (`shift_id`, `nama_shift`, `jam_mulai`, `jam_selesai`, `created_at`, `updated_at`, `deleted_at`) VALUES
	('6715fcd751635', 'pagi', '08:00:00', '16:00:00', '2024-10-21 00:03:51', '2024-10-21 00:03:51', NULL);

-- Dumping structure for table pjsp_absen.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.password_reset_tokens: ~0 rows (approximately)
DELETE FROM `password_reset_tokens`;

-- Dumping structure for table pjsp_absen.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.permissions: ~69 rows (approximately)
DELETE FROM `permissions`;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'view_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(2, 'view_any_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(3, 'create_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(4, 'update_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(5, 'restore_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(6, 'restore_any_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(7, 'replicate_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(8, 'reorder_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(9, 'delete_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(10, 'delete_any_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(11, 'force_delete_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(12, 'force_delete_any_jadwal', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(13, 'view_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(14, 'view_any_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(15, 'create_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(16, 'update_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(17, 'restore_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(18, 'restore_any_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(19, 'replicate_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(20, 'reorder_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(21, 'delete_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(22, 'delete_any_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(23, 'force_delete_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(24, 'force_delete_any_kantor', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(25, 'view_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(26, 'view_any_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(27, 'create_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(28, 'update_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(29, 'restore_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(30, 'restore_any_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(31, 'replicate_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(32, 'reorder_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(33, 'delete_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(34, 'delete_any_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(35, 'force_delete_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(36, 'force_delete_any_kehadiran', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(37, 'view_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(38, 'view_any_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(39, 'create_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(40, 'update_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(41, 'delete_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(42, 'delete_any_role', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(43, 'view_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(44, 'view_any_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(45, 'create_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(46, 'update_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(47, 'restore_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(48, 'restore_any_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(49, 'replicate_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(50, 'reorder_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(51, 'delete_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(52, 'delete_any_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(53, 'force_delete_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(54, 'force_delete_any_shift', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(55, 'view_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(56, 'view_any_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(57, 'create_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(58, 'update_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(59, 'restore_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(60, 'restore_any_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(61, 'replicate_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(62, 'reorder_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(63, 'delete_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(64, 'delete_any_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(65, 'force_delete_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(66, 'force_delete_any_user', 'web', '2024-10-22 08:11:44', '2024-10-22 08:11:44'),
	(67, 'create_cuti', 'web', '2024-10-23 02:48:19', '2024-10-23 02:48:19'),
	(68, 'view_cuti', 'web', '2024-10-23 02:49:25', '2024-10-23 02:49:25'),
	(69, 'view_any_cuti', 'web', '2024-10-23 02:49:25', '2024-10-23 02:49:25');

-- Dumping structure for table pjsp_absen.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.personal_access_tokens: ~0 rows (approximately)
DELETE FROM `personal_access_tokens`;

-- Dumping structure for table pjsp_absen.pulse_aggregates
CREATE TABLE IF NOT EXISTS `pulse_aggregates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bucket` int unsigned NOT NULL,
  `period` mediumint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `aggregate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(20,2) NOT NULL,
  `count` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pulse_aggregates_bucket_period_type_aggregate_key_hash_unique` (`bucket`,`period`,`type`,`aggregate`,`key_hash`),
  KEY `pulse_aggregates_period_bucket_index` (`period`,`bucket`),
  KEY `pulse_aggregates_type_index` (`type`),
  KEY `pulse_aggregates_period_type_aggregate_bucket_index` (`period`,`type`,`aggregate`,`bucket`)
) ENGINE=InnoDB AUTO_INCREMENT=889 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.pulse_aggregates: ~188 rows (approximately)
DELETE FROM `pulse_aggregates`;
INSERT INTO `pulse_aggregates` (`id`, `bucket`, `period`, `type`, `key`, `aggregate`, `value`, `count`) VALUES
	(1, 1729670100, 60, 'cache_hit', 'spatie.permission.cache', 'count', 3.00, NULL),
	(2, 1729670040, 360, 'cache_hit', 'spatie.permission.cache', 'count', 29.00, NULL),
	(3, 1729668960, 1440, 'cache_hit', 'spatie.permission.cache', 'count', 29.00, NULL),
	(4, 1729667520, 10080, 'cache_hit', 'spatie.permission.cache', 'count', 125.00, NULL),
	(13, 1729670160, 60, 'cache_hit', 'spatie.permission.cache', 'count', 21.00, NULL),
	(57, 1729670160, 60, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'count', 1.00, NULL),
	(58, 1729670040, 360, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'count', 1.00, NULL),
	(59, 1729668960, 1440, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'count', 1.00, NULL),
	(60, 1729667520, 10080, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'count', 1.00, NULL),
	(61, 1729670160, 60, 'slow_user_request', '2', 'count', 2.00, NULL),
	(62, 1729670040, 360, 'slow_user_request', '2', 'count', 2.00, NULL),
	(63, 1729668960, 1440, 'slow_user_request', '2', 'count', 2.00, NULL),
	(64, 1729667520, 10080, 'slow_user_request', '2', 'count', 4.00, NULL),
	(65, 1729670160, 60, 'user_request', '2', 'count', 2.00, NULL),
	(66, 1729670040, 360, 'user_request', '2', 'count', 2.00, NULL),
	(67, 1729668960, 1440, 'user_request', '2', 'count', 2.00, NULL),
	(68, 1729667520, 10080, 'user_request', '2', 'count', 4.00, NULL),
	(69, 1729670160, 60, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'max', 1212.00, NULL),
	(70, 1729670040, 360, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'max', 1212.00, NULL),
	(71, 1729668960, 1440, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'max', 1212.00, NULL),
	(72, 1729667520, 10080, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 'max', 1212.00, NULL),
	(81, 1729670160, 60, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'count', 1.00, NULL),
	(82, 1729670040, 360, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'count', 1.00, NULL),
	(83, 1729668960, 1440, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'count', 1.00, NULL),
	(84, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'count', 1.00, NULL),
	(97, 1729670160, 60, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'count', 1.00, NULL),
	(98, 1729670040, 360, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'count', 1.00, NULL),
	(99, 1729668960, 1440, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'count', 1.00, NULL),
	(100, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'count', 1.00, NULL),
	(101, 1729670160, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(102, 1729670040, 360, 'slow_user_request', '1', 'count', 1.00, NULL),
	(103, 1729668960, 1440, 'slow_user_request', '1', 'count', 1.00, NULL),
	(104, 1729667520, 10080, 'slow_user_request', '1', 'count', 17.00, NULL),
	(105, 1729670160, 60, 'user_request', '1', 'count', 1.00, NULL),
	(106, 1729670040, 360, 'user_request', '1', 'count', 1.00, NULL),
	(107, 1729668960, 1440, 'user_request', '1', 'count', 1.00, NULL),
	(108, 1729667520, 10080, 'user_request', '1', 'count', 31.00, NULL),
	(113, 1729670160, 60, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'max', 10594.00, NULL),
	(114, 1729670040, 360, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'max', 10594.00, NULL),
	(115, 1729668960, 1440, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'max', 10594.00, NULL),
	(116, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 'max', 10594.00, NULL),
	(117, 1729670160, 60, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'max', 20550.00, NULL),
	(118, 1729670040, 360, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'max', 20550.00, NULL),
	(119, 1729668960, 1440, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'max', 20550.00, NULL),
	(120, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 'max', 20550.00, NULL),
	(145, 1729670220, 60, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(161, 1729670280, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(165, 1729670400, 60, 'cache_hit', 'spatie.permission.cache', 'count', 14.00, NULL),
	(166, 1729670400, 360, 'cache_hit', 'spatie.permission.cache', 'count', 37.00, NULL),
	(167, 1729670400, 1440, 'cache_hit', 'spatie.permission.cache', 'count', 78.00, NULL),
	(177, 1729670400, 60, 'slow_request', '["GET","\\/","Closure"]', 'count', 1.00, NULL),
	(178, 1729670400, 360, 'slow_request', '["GET","\\/","Closure"]', 'count', 1.00, NULL),
	(179, 1729670400, 1440, 'slow_request', '["GET","\\/","Closure"]', 'count', 1.00, NULL),
	(180, 1729667520, 10080, 'slow_request', '["GET","\\/","Closure"]', 'count', 1.00, NULL),
	(181, 1729670400, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(182, 1729670400, 360, 'slow_user_request', '1', 'count', 1.00, NULL),
	(183, 1729670400, 1440, 'slow_user_request', '1', 'count', 16.00, NULL),
	(184, 1729670400, 60, 'user_request', '1', 'count', 1.00, NULL),
	(185, 1729670400, 360, 'user_request', '1', 'count', 1.00, NULL),
	(186, 1729670400, 1440, 'user_request', '1', 'count', 26.00, NULL),
	(189, 1729670400, 60, 'slow_request', '["GET","\\/","Closure"]', 'max', 1000.00, NULL),
	(190, 1729670400, 360, 'slow_request', '["GET","\\/","Closure"]', 'max', 1000.00, NULL),
	(191, 1729670400, 1440, 'slow_request', '["GET","\\/","Closure"]', 'max', 1000.00, NULL),
	(192, 1729667520, 10080, 'slow_request', '["GET","\\/","Closure"]', 'max', 1000.00, NULL),
	(237, 1729670460, 60, 'cache_hit', 'spatie.permission.cache', 'count', 16.00, NULL),
	(281, 1729670460, 60, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'count', 2.00, NULL),
	(282, 1729670400, 360, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'count', 2.00, NULL),
	(283, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'count', 2.00, NULL),
	(284, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'count', 2.00, NULL),
	(285, 1729670460, 60, 'slow_user_request', '2', 'count', 2.00, NULL),
	(286, 1729670400, 360, 'slow_user_request', '2', 'count', 2.00, NULL),
	(287, 1729670400, 1440, 'slow_user_request', '2', 'count', 2.00, NULL),
	(288, 1729670460, 60, 'user_request', '2', 'count', 2.00, NULL),
	(289, 1729670400, 360, 'user_request', '2', 'count', 2.00, NULL),
	(290, 1729670400, 1440, 'user_request', '2', 'count', 2.00, NULL),
	(297, 1729670460, 60, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'max', 1314.00, NULL),
	(298, 1729670400, 360, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'max', 1314.00, NULL),
	(299, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'max', 1314.00, NULL),
	(300, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 'max', 1314.00, NULL),
	(333, 1729670520, 60, 'cache_hit', 'spatie.permission.cache', 'count', 6.00, NULL),
	(357, 1729670640, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(361, 1729670880, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(362, 1729670760, 360, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(365, 1729671000, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(369, 1729671060, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(377, 1729671120, 60, 'cache_hit', 'spatie.permission.cache', 'count', 5.00, NULL),
	(378, 1729671120, 360, 'cache_hit', 'spatie.permission.cache', 'count', 23.00, NULL),
	(397, 1729671180, 60, 'cache_hit', 'spatie.permission.cache', 'count', 3.00, NULL),
	(405, 1729671180, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 1.00, NULL),
	(406, 1729671120, 360, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 1.00, NULL),
	(407, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 3.00, NULL),
	(408, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 3.00, NULL),
	(409, 1729671180, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(410, 1729671120, 360, 'slow_user_request', '1', 'count', 8.00, NULL),
	(411, 1729671180, 60, 'user_request', '1', 'count', 1.00, NULL),
	(412, 1729671120, 360, 'user_request', '1', 'count', 12.00, NULL),
	(421, 1729671180, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1626.00, NULL),
	(422, 1729671120, 360, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1626.00, NULL),
	(423, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1626.00, NULL),
	(424, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1626.00, NULL),
	(425, 1729671240, 60, 'cache_hit', 'spatie.permission.cache', 'count', 9.00, NULL),
	(429, 1729671240, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 2.00, NULL),
	(430, 1729671120, 360, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 3.00, NULL),
	(431, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 8.00, NULL),
	(432, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 8.00, NULL),
	(433, 1729671240, 60, 'slow_user_request', '1', 'count', 3.00, NULL),
	(434, 1729671240, 60, 'user_request', '1', 'count', 3.00, NULL),
	(445, 1729671240, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 4621.00, NULL),
	(446, 1729671120, 360, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 4621.00, NULL),
	(447, 1729670400, 1440, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 4621.00, NULL),
	(448, 1729667520, 10080, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 4621.00, NULL),
	(469, 1729671240, 60, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'count', 1.00, NULL),
	(470, 1729671120, 360, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'count', 4.00, NULL),
	(471, 1729670400, 1440, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'count', 4.00, NULL),
	(472, 1729667520, 10080, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'count', 4.00, NULL),
	(485, 1729671240, 60, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'max', 1155.00, NULL),
	(486, 1729671120, 360, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'max', 1923.00, NULL),
	(487, 1729670400, 1440, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'max', 1923.00, NULL),
	(488, 1729667520, 10080, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'max', 1923.00, NULL),
	(509, 1729671300, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(510, 1729671300, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(511, 1729671300, 60, 'user_request', '1', 'count', 5.00, NULL),
	(512, 1729671300, 60, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(525, 1729671300, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1135.00, NULL),
	(557, 1729671420, 60, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'count', 3.00, NULL),
	(558, 1729671420, 60, 'slow_user_request', '1', 'count', 3.00, NULL),
	(559, 1729671420, 60, 'user_request', '1', 'count', 3.00, NULL),
	(560, 1729671420, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(573, 1729671420, 60, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 'max', 1923.00, NULL),
	(613, 1729671480, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(614, 1729671480, 360, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 5.00, NULL),
	(615, 1729671480, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(616, 1729671480, 360, 'slow_user_request', '1', 'count', 7.00, NULL),
	(617, 1729671480, 60, 'user_request', '1', 'count', 2.00, NULL),
	(618, 1729671480, 360, 'user_request', '1', 'count', 13.00, NULL),
	(619, 1729671480, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(620, 1729671480, 360, 'cache_hit', 'spatie.permission.cache', 'count', 14.00, NULL),
	(629, 1729671480, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1059.00, NULL),
	(630, 1729671480, 360, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1305.00, NULL),
	(641, 1729671540, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(642, 1729671540, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(643, 1729671540, 60, 'user_request', '1', 'count', 2.00, NULL),
	(644, 1729671540, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(657, 1729671540, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1305.00, NULL),
	(669, 1729671600, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(670, 1729671600, 60, 'slow_user_request', '1', 'count', 1.00, NULL),
	(671, 1729671600, 60, 'user_request', '1', 'count', 2.00, NULL),
	(672, 1729671600, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(685, 1729671600, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1171.00, NULL),
	(697, 1729671660, 60, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(701, 1729671660, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(702, 1729671660, 60, 'slow_user_request', '1', 'count', 2.00, NULL),
	(703, 1729671660, 60, 'user_request', '1', 'count', 3.00, NULL),
	(717, 1729671660, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1234.00, NULL),
	(729, 1729671660, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 1.00, NULL),
	(730, 1729671480, 360, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 2.00, NULL),
	(745, 1729671660, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1019.00, NULL),
	(746, 1729671480, 360, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1145.00, NULL),
	(749, 1729671780, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'count', 1.00, NULL),
	(750, 1729671780, 60, 'slow_user_request', '1', 'count', 2.00, NULL),
	(751, 1729671780, 60, 'user_request', '1', 'count', 4.00, NULL),
	(752, 1729671780, 60, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(765, 1729671780, 60, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 'max', 1145.00, NULL),
	(769, 1729671780, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'count', 1.00, NULL),
	(785, 1729671780, 60, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 'max', 1257.00, NULL),
	(805, 1729671840, 60, 'user_request', '1', 'count', 4.00, NULL),
	(806, 1729671840, 360, 'user_request', '1', 'count', 4.00, NULL),
	(807, 1729671840, 1440, 'user_request', '1', 'count', 4.00, NULL),
	(808, 1729671840, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(809, 1729671840, 360, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(810, 1729671840, 1440, 'cache_hit', 'spatie.permission.cache', 'count', 10.00, NULL),
	(829, 1729671960, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(833, 1729672080, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(837, 1729672260, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(838, 1729672200, 360, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(841, 1729672380, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(845, 1729672560, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(846, 1729672560, 360, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(853, 1729672860, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(861, 1729673400, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(862, 1729673280, 360, 'cache_hit', 'spatie.permission.cache', 'count', 4.00, NULL),
	(863, 1729673280, 1440, 'cache_hit', 'spatie.permission.cache', 'count', 8.00, NULL),
	(869, 1729673520, 60, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(877, 1729673880, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(878, 1729673640, 360, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(881, 1729674060, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(882, 1729674000, 360, 'cache_hit', 'spatie.permission.cache', 'count', 2.00, NULL),
	(885, 1729674180, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(889, 1729674480, 60, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL),
	(890, 1729674360, 360, 'cache_hit', 'spatie.permission.cache', 'count', 1.00, NULL);

-- Dumping structure for table pjsp_absen.pulse_entries
CREATE TABLE IF NOT EXISTS `pulse_entries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pulse_entries_timestamp_index` (`timestamp`),
  KEY `pulse_entries_type_index` (`type`),
  KEY `pulse_entries_key_hash_index` (`key_hash`),
  KEY `pulse_entries_timestamp_type_key_hash_value_index` (`timestamp`,`type`,`key_hash`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.pulse_entries: ~201 rows (approximately)
DELETE FROM `pulse_entries`;
INSERT INTO `pulse_entries` (`id`, `timestamp`, `type`, `key`, `value`) VALUES
	(1, 1729670154, 'cache_hit', 'spatie.permission.cache', NULL),
	(2, 1729670156, 'cache_hit', 'spatie.permission.cache', NULL),
	(3, 1729670158, 'cache_hit', 'spatie.permission.cache', NULL),
	(4, 1729670160, 'cache_hit', 'spatie.permission.cache', NULL),
	(5, 1729670161, 'cache_hit', 'spatie.permission.cache', NULL),
	(6, 1729670164, 'cache_hit', 'spatie.permission.cache', NULL),
	(7, 1729670166, 'cache_hit', 'spatie.permission.cache', NULL),
	(8, 1729670167, 'cache_hit', 'spatie.permission.cache', NULL),
	(9, 1729670169, 'cache_hit', 'spatie.permission.cache', NULL),
	(10, 1729670171, 'cache_hit', 'spatie.permission.cache', NULL),
	(11, 1729670173, 'cache_hit', 'spatie.permission.cache', NULL),
	(12, 1729670175, 'cache_hit', 'spatie.permission.cache', NULL),
	(13, 1729670176, 'cache_hit', 'spatie.permission.cache', NULL),
	(14, 1729670177, 'cache_hit', 'spatie.permission.cache', NULL),
	(15, 1729670179, 'slow_request', '["GET","\\/presensi","App\\\\Livewire\\\\Presensi"]', 1212),
	(16, 1729670179, 'slow_user_request', '2', NULL),
	(17, 1729670179, 'user_request', '2', NULL),
	(18, 1729670184, 'cache_hit', 'spatie.permission.cache', NULL),
	(19, 1729670188, 'cache_hit', 'spatie.permission.cache', NULL),
	(20, 1729670190, 'slow_request', '["GET","\\/admin\\/kehadirans","App\\\\Filament\\\\Resources\\\\KehadiranResource\\\\Pages\\\\ListKehadirans@__invoke"]', 10594),
	(21, 1729670190, 'slow_user_request', '2', NULL),
	(22, 1729670190, 'user_request', '2', NULL),
	(23, 1729670191, 'cache_hit', 'spatie.permission.cache', NULL),
	(24, 1729670180, 'slow_request', '["GET","\\/admin\\/cutis","App\\\\Filament\\\\Resources\\\\CutiResource\\\\Pages\\\\ListCutis@__invoke"]', 20550),
	(25, 1729670180, 'slow_user_request', '1', NULL),
	(26, 1729670180, 'user_request', '1', NULL),
	(27, 1729670181, 'cache_hit', 'spatie.permission.cache', NULL),
	(28, 1729670202, 'cache_hit', 'spatie.permission.cache', NULL),
	(29, 1729670203, 'cache_hit', 'spatie.permission.cache', NULL),
	(30, 1729670205, 'cache_hit', 'spatie.permission.cache', NULL),
	(31, 1729670208, 'cache_hit', 'spatie.permission.cache', NULL),
	(32, 1729670213, 'cache_hit', 'spatie.permission.cache', NULL),
	(33, 1729670218, 'cache_hit', 'spatie.permission.cache', NULL),
	(34, 1729670223, 'cache_hit', 'spatie.permission.cache', NULL),
	(35, 1729670228, 'cache_hit', 'spatie.permission.cache', NULL),
	(36, 1729670233, 'cache_hit', 'spatie.permission.cache', NULL),
	(37, 1729670265, 'cache_hit', 'spatie.permission.cache', NULL),
	(38, 1729670285, 'cache_hit', 'spatie.permission.cache', NULL),
	(39, 1729670400, 'cache_hit', 'spatie.permission.cache', NULL),
	(40, 1729670403, 'cache_hit', 'spatie.permission.cache', NULL),
	(41, 1729670409, 'cache_hit', 'spatie.permission.cache', NULL),
	(42, 1729670411, 'slow_request', '["GET","\\/","Closure"]', 1000),
	(43, 1729670411, 'slow_user_request', '1', NULL),
	(44, 1729670411, 'user_request', '1', NULL),
	(45, 1729670419, 'cache_hit', 'spatie.permission.cache', NULL),
	(46, 1729670421, 'cache_hit', 'spatie.permission.cache', NULL),
	(47, 1729670423, 'cache_hit', 'spatie.permission.cache', NULL),
	(48, 1729670423, 'cache_hit', 'spatie.permission.cache', NULL),
	(49, 1729670424, 'cache_hit', 'spatie.permission.cache', NULL),
	(50, 1729670424, 'cache_hit', 'spatie.permission.cache', NULL),
	(51, 1729670424, 'cache_hit', 'spatie.permission.cache', NULL),
	(52, 1729670425, 'cache_hit', 'spatie.permission.cache', NULL),
	(53, 1729670428, 'cache_hit', 'spatie.permission.cache', NULL),
	(54, 1729670431, 'cache_hit', 'spatie.permission.cache', NULL),
	(55, 1729670435, 'cache_hit', 'spatie.permission.cache', NULL),
	(56, 1729670464, 'cache_hit', 'spatie.permission.cache', NULL),
	(57, 1729670464, 'cache_hit', 'spatie.permission.cache', NULL),
	(58, 1729670464, 'cache_hit', 'spatie.permission.cache', NULL),
	(59, 1729670464, 'cache_hit', 'spatie.permission.cache', NULL),
	(60, 1729670465, 'cache_hit', 'spatie.permission.cache', NULL),
	(61, 1729670470, 'cache_hit', 'spatie.permission.cache', NULL),
	(62, 1729670475, 'cache_hit', 'spatie.permission.cache', NULL),
	(63, 1729670477, 'cache_hit', 'spatie.permission.cache', NULL),
	(64, 1729670480, 'cache_hit', 'spatie.permission.cache', NULL),
	(65, 1729670484, 'cache_hit', 'spatie.permission.cache', NULL),
	(66, 1729670490, 'cache_hit', 'spatie.permission.cache', NULL),
	(67, 1729670493, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 1314),
	(68, 1729670493, 'slow_user_request', '2', NULL),
	(69, 1729670493, 'user_request', '2', NULL),
	(70, 1729670494, 'cache_hit', 'spatie.permission.cache', NULL),
	(71, 1729670496, 'slow_request', '["GET","\\/admin\\/jadwals","App\\\\Filament\\\\Resources\\\\JadwalResource\\\\Pages\\\\ListJadwals@__invoke"]', 1005),
	(72, 1729670496, 'slow_user_request', '2', NULL),
	(73, 1729670496, 'user_request', '2', NULL),
	(74, 1729670497, 'cache_hit', 'spatie.permission.cache', NULL),
	(75, 1729670504, 'cache_hit', 'spatie.permission.cache', NULL),
	(76, 1729670510, 'cache_hit', 'spatie.permission.cache', NULL),
	(77, 1729670516, 'cache_hit', 'spatie.permission.cache', NULL),
	(78, 1729670521, 'cache_hit', 'spatie.permission.cache', NULL),
	(79, 1729670526, 'cache_hit', 'spatie.permission.cache', NULL),
	(80, 1729670531, 'cache_hit', 'spatie.permission.cache', NULL),
	(81, 1729670541, 'cache_hit', 'spatie.permission.cache', NULL),
	(82, 1729670561, 'cache_hit', 'spatie.permission.cache', NULL),
	(83, 1729670566, 'cache_hit', 'spatie.permission.cache', NULL),
	(84, 1729670650, 'cache_hit', 'spatie.permission.cache', NULL),
	(85, 1729670890, 'cache_hit', 'spatie.permission.cache', NULL),
	(86, 1729671056, 'cache_hit', 'spatie.permission.cache', NULL),
	(87, 1729671061, 'cache_hit', 'spatie.permission.cache', NULL),
	(88, 1729671080, 'cache_hit', 'spatie.permission.cache', NULL),
	(89, 1729671121, 'cache_hit', 'spatie.permission.cache', NULL),
	(90, 1729671146, 'cache_hit', 'spatie.permission.cache', NULL),
	(91, 1729671151, 'cache_hit', 'spatie.permission.cache', NULL),
	(92, 1729671156, 'cache_hit', 'spatie.permission.cache', NULL),
	(93, 1729671166, 'cache_hit', 'spatie.permission.cache', NULL),
	(94, 1729671230, 'cache_hit', 'spatie.permission.cache', NULL),
	(95, 1729671235, 'cache_hit', 'spatie.permission.cache', NULL),
	(96, 1729671238, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 1626),
	(97, 1729671238, 'slow_user_request', '1', NULL),
	(98, 1729671238, 'user_request', '1', NULL),
	(99, 1729671239, 'cache_hit', 'spatie.permission.cache', NULL),
	(100, 1729671246, 'cache_hit', 'spatie.permission.cache', NULL),
	(101, 1729671242, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 4621),
	(102, 1729671242, 'slow_user_request', '1', NULL),
	(103, 1729671242, 'user_request', '1', NULL),
	(104, 1729671243, 'cache_hit', 'spatie.permission.cache', NULL),
	(105, 1729671245, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1646),
	(106, 1729671245, 'slow_user_request', '1', NULL),
	(107, 1729671245, 'user_request', '1', NULL),
	(108, 1729671246, 'cache_hit', 'spatie.permission.cache', NULL),
	(109, 1729671247, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 1155),
	(110, 1729671247, 'slow_user_request', '1', NULL),
	(111, 1729671247, 'user_request', '1', NULL),
	(112, 1729671248, 'cache_hit', 'spatie.permission.cache', NULL),
	(113, 1729671250, 'cache_hit', 'spatie.permission.cache', NULL),
	(114, 1729671256, 'cache_hit', 'spatie.permission.cache', NULL),
	(115, 1729671276, 'cache_hit', 'spatie.permission.cache', NULL),
	(116, 1729671281, 'cache_hit', 'spatie.permission.cache', NULL),
	(117, 1729671291, 'cache_hit', 'spatie.permission.cache', NULL),
	(118, 1729671303, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1135),
	(119, 1729671303, 'slow_user_request', '1', NULL),
	(120, 1729671303, 'user_request', '1', NULL),
	(121, 1729671304, 'cache_hit', 'spatie.permission.cache', NULL),
	(122, 1729671304, 'user_request', '1', NULL),
	(123, 1729671305, 'cache_hit', 'spatie.permission.cache', NULL),
	(124, 1729671324, 'user_request', '1', NULL),
	(125, 1729671324, 'cache_hit', 'spatie.permission.cache', NULL),
	(126, 1729671325, 'user_request', '1', NULL),
	(127, 1729671325, 'user_request', '1', NULL),
	(128, 1729671326, 'cache_hit', 'spatie.permission.cache', NULL),
	(129, 1729671463, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 1237),
	(130, 1729671463, 'slow_user_request', '1', NULL),
	(131, 1729671463, 'user_request', '1', NULL),
	(132, 1729671464, 'cache_hit', 'spatie.permission.cache', NULL),
	(133, 1729671465, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 1923),
	(134, 1729671465, 'slow_user_request', '1', NULL),
	(135, 1729671465, 'user_request', '1', NULL),
	(136, 1729671467, 'cache_hit', 'spatie.permission.cache', NULL),
	(137, 1729671473, 'slow_request', '["POST","\\/admin\\/users\\/2\\/edit","via \\/livewire\\/update"]', 1116),
	(138, 1729671473, 'slow_user_request', '1', NULL),
	(139, 1729671473, 'user_request', '1', NULL),
	(140, 1729671534, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1059),
	(141, 1729671534, 'slow_user_request', '1', NULL),
	(142, 1729671534, 'user_request', '1', NULL),
	(143, 1729671535, 'cache_hit', 'spatie.permission.cache', NULL),
	(144, 1729671536, 'user_request', '1', NULL),
	(145, 1729671536, 'cache_hit', 'spatie.permission.cache', NULL),
	(146, 1729671580, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1305),
	(147, 1729671580, 'slow_user_request', '1', NULL),
	(148, 1729671580, 'user_request', '1', NULL),
	(149, 1729671582, 'cache_hit', 'spatie.permission.cache', NULL),
	(150, 1729671582, 'user_request', '1', NULL),
	(151, 1729671583, 'cache_hit', 'spatie.permission.cache', NULL),
	(152, 1729671618, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1171),
	(153, 1729671618, 'slow_user_request', '1', NULL),
	(154, 1729671618, 'user_request', '1', NULL),
	(155, 1729671619, 'cache_hit', 'spatie.permission.cache', NULL),
	(156, 1729671620, 'user_request', '1', NULL),
	(157, 1729671621, 'cache_hit', 'spatie.permission.cache', NULL),
	(158, 1729671670, 'cache_hit', 'spatie.permission.cache', NULL),
	(159, 1729671707, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1234),
	(160, 1729671707, 'slow_user_request', '1', NULL),
	(161, 1729671707, 'user_request', '1', NULL),
	(162, 1729671708, 'cache_hit', 'spatie.permission.cache', NULL),
	(163, 1729671709, 'user_request', '1', NULL),
	(164, 1729671710, 'cache_hit', 'spatie.permission.cache', NULL),
	(165, 1729671714, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 1019),
	(166, 1729671714, 'slow_user_request', '1', NULL),
	(167, 1729671714, 'user_request', '1', NULL),
	(168, 1729671715, 'cache_hit', 'spatie.permission.cache', NULL),
	(169, 1729671822, 'slow_request', '["GET","\\/admin\\/users","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\ListUsers@__invoke"]', 1145),
	(170, 1729671822, 'slow_user_request', '1', NULL),
	(171, 1729671822, 'user_request', '1', NULL),
	(172, 1729671822, 'cache_hit', 'spatie.permission.cache', NULL),
	(173, 1729671828, 'slow_request', '["GET","\\/admin\\/users\\/{record}\\/edit","App\\\\Filament\\\\Resources\\\\UserResource\\\\Pages\\\\EditUser@__invoke"]', 1257),
	(174, 1729671828, 'slow_user_request', '1', NULL),
	(175, 1729671828, 'user_request', '1', NULL),
	(176, 1729671829, 'cache_hit', 'spatie.permission.cache', NULL),
	(177, 1729671830, 'user_request', '1', NULL),
	(178, 1729671830, 'cache_hit', 'spatie.permission.cache', NULL),
	(179, 1729671839, 'user_request', '1', NULL),
	(180, 1729671839, 'cache_hit', 'spatie.permission.cache', NULL),
	(181, 1729671840, 'user_request', '1', NULL),
	(182, 1729671841, 'cache_hit', 'spatie.permission.cache', NULL),
	(183, 1729671841, 'user_request', '1', NULL),
	(184, 1729671842, 'cache_hit', 'spatie.permission.cache', NULL),
	(185, 1729671842, 'user_request', '1', NULL),
	(186, 1729671849, 'user_request', '1', NULL),
	(187, 1729671970, 'cache_hit', 'spatie.permission.cache', NULL),
	(188, 1729672090, 'cache_hit', 'spatie.permission.cache', NULL),
	(189, 1729672270, 'cache_hit', 'spatie.permission.cache', NULL),
	(190, 1729672390, 'cache_hit', 'spatie.permission.cache', NULL),
	(191, 1729672570, 'cache_hit', 'spatie.permission.cache', NULL),
	(192, 1729672571, 'cache_hit', 'spatie.permission.cache', NULL),
	(193, 1729672870, 'cache_hit', 'spatie.permission.cache', NULL),
	(194, 1729672871, 'cache_hit', 'spatie.permission.cache', NULL),
	(195, 1729673410, 'cache_hit', 'spatie.permission.cache', NULL),
	(196, 1729673411, 'cache_hit', 'spatie.permission.cache', NULL),
	(197, 1729673529, 'cache_hit', 'spatie.permission.cache', NULL),
	(198, 1729673531, 'cache_hit', 'spatie.permission.cache', NULL),
	(199, 1729673890, 'cache_hit', 'spatie.permission.cache', NULL),
	(200, 1729674070, 'cache_hit', 'spatie.permission.cache', NULL),
	(201, 1729674190, 'cache_hit', 'spatie.permission.cache', NULL),
	(202, 1729674490, 'cache_hit', 'spatie.permission.cache', NULL);

-- Dumping structure for table pjsp_absen.pulse_values
CREATE TABLE IF NOT EXISTS `pulse_values` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` int unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pulse_values_type_key_hash_unique` (`type`,`key_hash`),
  KEY `pulse_values_timestamp_index` (`timestamp`),
  KEY `pulse_values_type_index` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.pulse_values: ~0 rows (approximately)
DELETE FROM `pulse_values`;

-- Dumping structure for table pjsp_absen.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.roles: ~2 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'super_admin', 'web', '2024-10-22 08:11:43', '2024-10-22 08:11:43'),
	(2, 'Karyawan', 'web', '2024-10-22 08:12:46', '2024-10-22 08:12:46');

-- Dumping structure for table pjsp_absen.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.role_has_permissions: ~71 rows (approximately)
DELETE FROM `role_has_permissions`;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(48, 1),
	(49, 1),
	(50, 1),
	(51, 1),
	(52, 1),
	(53, 1),
	(54, 1),
	(55, 1),
	(56, 1),
	(57, 1),
	(58, 1),
	(59, 1),
	(60, 1),
	(61, 1),
	(62, 1),
	(63, 1),
	(64, 1),
	(65, 1),
	(66, 1),
	(2, 2),
	(26, 2),
	(67, 2),
	(68, 2),
	(69, 2);

-- Dumping structure for table pjsp_absen.tr_cuti
CREATE TABLE IF NOT EXISTS `tr_cuti` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `alasan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Pending','Disetujui','Ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tr_cuti_user_id_foreign` (`user_id`),
  CONSTRAINT `tr_cuti_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.tr_cuti: ~1 rows (approximately)
DELETE FROM `tr_cuti`;
INSERT INTO `tr_cuti` (`id`, `user_id`, `tanggal_mulai`, `tanggal_selesai`, `alasan`, `status`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 2, '2024-10-23', '2024-10-23', 'keluarga', 'Disetujui', 'belum', '2024-10-23 07:26:38', '2024-10-23 07:35:36', NULL);

-- Dumping structure for table pjsp_absen.tr_jadwal
CREATE TABLE IF NOT EXISTS `tr_jadwal` (
  `jadwal_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kntr_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shift_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wfa` int DEFAULT '0',
  `banned` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`jadwal_id`),
  UNIQUE KEY `m_jadwal_user_id_unique` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.tr_jadwal: ~2 rows (approximately)
DELETE FROM `tr_jadwal`;
INSERT INTO `tr_jadwal` (`jadwal_id`, `user_id`, `kntr_id`, `shift_id`, `wfa`, `banned`, `created_at`, `updated_at`, `deleted_at`) VALUES
	('67170da979247', '2', '6716007bba8cd', '6715fcd751635', 0, 0, '2024-10-21 19:27:53', '2024-10-22 08:59:54', NULL),
	('6717141cae300', '1', '6716007bba8cd', '6715fcd751635', 1, 0, '2024-10-21 19:55:24', '2024-10-21 19:55:24', NULL);

-- Dumping structure for table pjsp_absen.tr_kehadiran
CREATE TABLE IF NOT EXISTS `tr_kehadiran` (
  `kehadiran_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jadwal_latitude` double NOT NULL,
  `jadwal_longitude` double NOT NULL,
  `jadwal_jam_mulai` time NOT NULL,
  `jadwal_jam_selesai` time NOT NULL,
  `start_latitude` double NOT NULL,
  `start_longitude` double NOT NULL,
  `end_latitude` double DEFAULT NULL,
  `end_longitude` double DEFAULT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`kehadiran_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.tr_kehadiran: ~2 rows (approximately)
DELETE FROM `tr_kehadiran`;
INSERT INTO `tr_kehadiran` (`kehadiran_id`, `user_id`, `jadwal_latitude`, `jadwal_longitude`, `jadwal_jam_mulai`, `jadwal_jam_selesai`, `start_latitude`, `start_longitude`, `end_latitude`, `end_longitude`, `jam_mulai`, `jam_selesai`, `created_at`, `updated_at`, `deleted_at`) VALUES
	('67174fef86ac6', '1', -7.1314044477206, 112.09080170835, '08:00:00', '16:00:00', -7.1294457, 112.083395, -7.1294457, 112.083395, '14:10:39', '14:10:47', '2024-10-22 07:10:39', '2024-10-22 07:10:47', NULL),
	('6717606592c2b', '2', -7.1314044477206, 112.09080170835, '08:00:00', '16:00:00', -7.1294457, 112.083395, -7.1294457, 112.083395, '15:20:53', '15:46:51', '2024-10-22 08:20:53', '2024-10-22 08:46:51', NULL);

-- Dumping structure for table pjsp_absen.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table pjsp_absen.users: ~2 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `remember_token`, `image`, `created_at`, `updated_at`) VALUES
	(1, 'Super Admin', 'admin', 'admin@mail.com', NULL, '$2y$12$DkWkkFdt9kFK6.aVu/ig.Ob5InHKgYZxr312UekW3haYtgcnBgQ6a', NULL, NULL, '2024-10-20 19:21:51', '2024-10-20 19:21:51'),
	(2, 'didik', 'didik', 'didik@mail.com', NULL, '$2y$12$oEWWmlORd89RXd5jwdgapObrlCIqmOVM3y3bLHyYRkMMEkADQNOEy', NULL, NULL, '2024-10-21 01:00:05', '2024-10-23 08:24:02');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
