-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2026 at 01:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `theparak_library_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add book', 7, 'add_book'),
(26, 'Can change book', 7, 'change_book'),
(27, 'Can delete book', 7, 'delete_book'),
(28, 'Can view book', 7, 'view_book'),
(29, 'Can add category', 8, 'add_category'),
(30, 'Can change category', 8, 'change_category'),
(31, 'Can delete category', 8, 'delete_category'),
(32, 'Can view category', 8, 'view_category'),
(33, 'Can add author', 9, 'add_author'),
(34, 'Can change author', 9, 'change_author'),
(35, 'Can delete author', 9, 'delete_author'),
(36, 'Can view author', 9, 'view_author'),
(37, 'Can add borrowing', 10, 'add_borrowing'),
(38, 'Can change borrowing', 10, 'change_borrowing'),
(39, 'Can delete borrowing', 10, 'delete_borrowing'),
(40, 'Can view borrowing', 10, 'view_borrowing'),
(41, 'Can add review', 11, 'add_review'),
(42, 'Can change review', 11, 'change_review'),
(43, 'Can delete review', 11, 'delete_review'),
(44, 'Can view review', 11, 'view_review');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$XiYXVSJEBO9leSDcTiiyon$UfxZDeMKHC+n0SQLH0jvnrcdo0XUjABJKg6RcFzRvD8=', '2026-03-29 11:07:32.674522', 1, '68063361', 'Watcharapakron', 'Phopa', 'jatsteamsam@gmail.com', 1, 1, '2026-03-26 12:27:36.000000'),
(2, 'pbkdf2_sha256$600000$olfDpBxD0LDC5D2wQF8XWe$/z+mXfmgeWIedVAZkDMltVnN+rYjCvofIvr8ljmjTOc=', '2026-03-29 11:16:49.083560', 0, '6621393', 'Watcharapakron', 'Phopa', 'watcharapakron.pho@spumail.net', 0, 1, '2026-03-26 12:29:31.000000'),
(5, 'pbkdf2_sha256$600000$Okb6hbaCq2TW4zqapO3z51$6//FK25EUUJw6O5CyE2XTm7TkVljGnESQxPL2picVcU=', NULL, 0, '6621493', 'Arraiwa', 'Maiyatam', 'arraiwa.mai@spumail.net', 0, 1, '2026-03-29 06:16:01.186779');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-03-26 12:29:31.829802', '2', '6621393', 1, '[{\"added\": {}}]', 4, 1),
(2, '2026-03-26 12:30:30.818027', '2', '6621393', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]', 4, 1),
(3, '2026-03-26 12:32:05.009574', '1', '68063361', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(4, '2026-03-29 04:58:02.075746', '2', '6621393', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'library', 'author'),
(7, 'library', 'book'),
(10, 'library', 'borrowing'),
(8, 'library', 'category'),
(11, 'library', 'review'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-26 12:18:14.279037'),
(2, 'auth', '0001_initial', '2026-03-26 12:18:14.739551'),
(3, 'admin', '0001_initial', '2026-03-26 12:18:14.827668'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-03-26 12:18:14.833909'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-26 12:18:14.842115'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-03-26 12:18:14.898038'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-03-26 12:18:14.946209'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-03-26 12:18:14.958076'),
(9, 'auth', '0004_alter_user_username_opts', '2026-03-26 12:18:14.964428'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-03-26 12:18:15.006921'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-03-26 12:18:15.009018'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-03-26 12:18:15.020307'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-03-26 12:18:15.034315'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-03-26 12:18:15.048604'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-03-26 12:18:15.062768'),
(16, 'auth', '0011_update_proxy_permissions', '2026-03-26 12:18:15.070430'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-03-26 12:18:15.084330'),
(18, 'sessions', '0001_initial', '2026-03-26 12:18:15.118506'),
(19, 'library', '0001_initial', '2026-03-26 12:19:14.854015'),
(20, 'library', '0002_remove_book_pdf_file_alter_author_id_alter_book_id_and_more', '2026-03-29 04:02:56.489058'),
(21, 'library', '0003_alter_borrowing_borrow_date', '2026-03-29 05:22:30.266691');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('fb2hrzde4m2k4e28o8e01vszd3996z3o', '.eJxVjMEOwiAQBf-FsyGwQAGP3v0GAuwiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BJmZGcG7PS7pZgf1HaA99hunefe1mVOfFf4QQe_dqTn5XD_Dmoc9Vub6NAgwWRNJEelWNJCqSI0FlGs1B4FocgebZ5AeqOKAsQEkjI5B-z9AfyJOG4:1w6iPi:LbdvXRfZdV3m2RktaVLI_4sIiKWqr0LJD6Nl-YB6heI', '2026-04-12 05:10:18.302010'),
('klvkgmfedgdf0ag1jdts3ber5ftwpwx1', '.eJxVjMEOwiAQBf-FsyGwQAGP3v0GAuwiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BJmZGcG7PS7pZgf1HaA99hunefe1mVOfFf4QQe_dqTn5XD_Dmoc9Vub6NAgwWRNJEelWNJCqSI0FlGs1B4FocgebZ5AeqOKAsQEkjI5B-z9AfyJOG4:1w6o8P:4zzWvBdFkkLxGZ-_8BA_SU_Gyg458DebiQvcFpsO8m8', '2026-04-12 11:16:49.085409'),
('vqp16pbbtxumqnpp7cx1x3ubco9i701a', '.eJxVjDsOwyAQRO9CHSE-azAp0_sMaFkgOIlAMnYV5e6xJRdJOfPezJt53Nbit54WP0d2ZZJdfruA9Ez1APGB9d44tbouc-CHwk_a-dRiet1O9--gYC_72oWoCXMYMWEeAAQgjCm4DATWWVSR9qCENUZSVnoQRsqEoLM2ICiyzxcMNjhZ:1w6jIw:nLI9raPfxbt_AAFE2M9tc1hgDivh3zqjOAiIXVu_KKc', '2026-04-12 06:07:22.237232'),
('yaz6i3b14qfzc28cw0txcv0st5lop8l5', '.eJxVjMEOwiAQBf-FsyGwQAGP3v0GAuwiVQNJaU_Gf9cmPej1zcx7sRC3tYZt0BJmZGcG7PS7pZgf1HaA99hunefe1mVOfFf4QQe_dqTn5XD_Dmoc9Vub6NAgwWRNJEelWNJCqSI0FlGs1B4FocgebZ5AeqOKAsQEkjI5B-z9AfyJOG4:1w6jQR:7r7ZwbDGJe7efDCTdcLcJ1kZz4V9GXpK92CK8KQxrF8', '2026-04-12 06:15:07.043464');

-- --------------------------------------------------------

--
-- Table structure for table `library_author`
--

CREATE TABLE `library_author` (
  `id` bigint(20) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `bio` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_author`
--

INSERT INTO `library_author` (`id`, `first_name`, `last_name`, `bio`, `created_at`) VALUES
(1, 'โชก้า', 'บ้ามาก', 'ทดลอง', '2026-03-29 04:08:50.727973'),
(2, 'วัชรปกรณ์', 'โพธิ์พา', 'รหัสนักศึกษา 6621393', '2026-03-29 06:18:05.657248');

-- --------------------------------------------------------

--
-- Table structure for table `library_book`
--

CREATE TABLE `library_book` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `description` longtext NOT NULL,
  `publication_date` date DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_book`
--

INSERT INTO `library_book` (`id`, `title`, `isbn`, `description`, `publication_date`, `pages`, `cover_image`, `is_available`, `created_at`, `updated_at`, `category_id`) VALUES
(2, 'ทดลอง', '', 'ทดลอง', '2026-03-29', NULL, 'book_covers/AMBALANGKUNG_ambatukam_jmk48_ngawiflix_memes_memeindo_masukberanda_fyppppppp_IUfbRdj.jpg', 1, '2026-03-29 04:47:50.780401', '2026-03-29 11:06:43.956603', 1);

-- --------------------------------------------------------

--
-- Table structure for table `library_book_authors`
--

CREATE TABLE `library_book_authors` (
  `id` int(11) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `author_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_book_authors`
--

INSERT INTO `library_book_authors` (`id`, `book_id`, `author_id`) VALUES
(2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `library_borrowing`
--

CREATE TABLE `library_borrowing` (
  `id` bigint(20) NOT NULL,
  `borrow_date` datetime(6) NOT NULL,
  `return_date` datetime(6) DEFAULT NULL,
  `due_date` datetime(6) NOT NULL,
  `is_returned` tinyint(1) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_borrowing`
--

INSERT INTO `library_borrowing` (`id`, `borrow_date`, `return_date`, `due_date`, `is_returned`, `book_id`, `student_id`) VALUES
(7, '2026-03-14 05:22:35.897423', '2026-03-29 06:07:13.900396', '2026-03-21 05:22:35.897423', 1, 2, 2),
(10, '2026-03-29 06:15:10.074340', '2026-03-29 11:06:43.954125', '2026-04-05 06:15:10.074281', 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `library_category`
--

CREATE TABLE `library_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_category`
--

INSERT INTO `library_category` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'สยองขวัญ', 'เรื่องผีๆ หน้ากลัวๆ', '2026-03-29 04:07:10.450331');

-- --------------------------------------------------------

--
-- Table structure for table `library_review`
--

CREATE TABLE `library_review` (
  `id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_review`
--

INSERT INTO `library_review` (`id`, `rating`, `comment`, `created_at`, `book_id`, `student_id`) VALUES
(1, 5, 'ดี', '2026-03-29 11:16:56.482994', 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `library_author`
--
ALTER TABLE `library_author`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `library_book`
--
ALTER TABLE `library_book`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `library_book_category_id_c90a2d6d_fk` (`category_id`);

--
-- Indexes for table `library_book_authors`
--
ALTER TABLE `library_book_authors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `library_book_authors_book_id_author_id_5a77f71a_uniq` (`book_id`,`author_id`),
  ADD KEY `library_book_authors_author_id_93ee7ed3_fk` (`author_id`);

--
-- Indexes for table `library_borrowing`
--
ALTER TABLE `library_borrowing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `library_borrowing_student_id_5edbe1fd_fk_auth_user_id` (`student_id`),
  ADD KEY `library_borrowing_book_id_339e1800_fk` (`book_id`);

--
-- Indexes for table `library_category`
--
ALTER TABLE `library_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `library_review`
--
ALTER TABLE `library_review`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `library_review_book_id_student_id_c3f9d5d0_uniq` (`book_id`,`student_id`),
  ADD KEY `library_review_student_id_b855301a_fk_auth_user_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `library_author`
--
ALTER TABLE `library_author`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `library_book`
--
ALTER TABLE `library_book`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `library_book_authors`
--
ALTER TABLE `library_book_authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `library_borrowing`
--
ALTER TABLE `library_borrowing`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `library_category`
--
ALTER TABLE `library_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `library_review`
--
ALTER TABLE `library_review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `library_book`
--
ALTER TABLE `library_book`
  ADD CONSTRAINT `library_book_category_id_c90a2d6d_fk` FOREIGN KEY (`category_id`) REFERENCES `library_category` (`id`);

--
-- Constraints for table `library_book_authors`
--
ALTER TABLE `library_book_authors`
  ADD CONSTRAINT `library_book_authors_author_id_93ee7ed3_fk` FOREIGN KEY (`author_id`) REFERENCES `library_author` (`id`),
  ADD CONSTRAINT `library_book_authors_book_id_14d130f6_fk` FOREIGN KEY (`book_id`) REFERENCES `library_book` (`id`);

--
-- Constraints for table `library_borrowing`
--
ALTER TABLE `library_borrowing`
  ADD CONSTRAINT `library_borrowing_book_id_339e1800_fk` FOREIGN KEY (`book_id`) REFERENCES `library_book` (`id`),
  ADD CONSTRAINT `library_borrowing_student_id_5edbe1fd_fk_auth_user_id` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `library_review`
--
ALTER TABLE `library_review`
  ADD CONSTRAINT `library_review_book_id_3ba0bb54_fk` FOREIGN KEY (`book_id`) REFERENCES `library_book` (`id`),
  ADD CONSTRAINT `library_review_student_id_b855301a_fk_auth_user_id` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
