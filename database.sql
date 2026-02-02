-- ===================================================
-- ThinkPHP积分系统数据库设计
-- 数据库版本: MySQL 8.0+
-- 字符集: utf8mb4
-- ===================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS `points_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `points_system`;

-- ===================================================
-- 1. 用户表
-- ===================================================
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_phone` (`phone`),
  KEY `idx_email` (`email`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ===================================================
-- 2. 积分账户表
-- ===================================================
DROP TABLE IF EXISTS `point_accounts`;
CREATE TABLE `point_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `total_points` bigint NOT NULL DEFAULT '0' COMMENT '总积分（历史累计）',
  `available_points` bigint NOT NULL DEFAULT '0' COMMENT '可用积分（当前余额）',
  `frozen_points` bigint NOT NULL DEFAULT '0' COMMENT '冻结积分',
  `used_points` bigint NOT NULL DEFAULT '0' COMMENT '已使用积分',
  `level` int NOT NULL DEFAULT '1' COMMENT '积分等级',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号（乐观锁）',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  KEY `idx_level` (`level`),
  KEY `idx_available_points` (`available_points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分账户表';

-- ===================================================
-- 3. 积分规则表
-- ===================================================
DROP TABLE IF EXISTS `point_rules`;
CREATE TABLE `point_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `name` varchar(100) NOT NULL COMMENT '规则名称',
  `code` varchar(50) NOT NULL COMMENT '规则编码',
  `type` varchar(20) NOT NULL COMMENT '规则类型：sign_in-签到，task-任务，consume-消费，referral-推荐，upgrade-升级，manual-手动，scheduled-定时',
  `points` int NOT NULL COMMENT '积分数量',
  `description` text COMMENT '规则描述',
  `config` json DEFAULT NULL COMMENT '规则配置（JSON格式）',
  `icon` varchar(255) DEFAULT NULL COMMENT '规则图标',
  `priority` int NOT NULL DEFAULT '0' COMMENT '优先级（数字越大优先级越高）',
  `max_times_per_day` int DEFAULT NULL COMMENT '每天最大执行次数',
  `max_times_total` int DEFAULT NULL COMMENT '总共最大执行次数',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '生效开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '生效结束时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分规则表';

-- ===================================================
-- 4. 积分记录表
-- ===================================================
DROP TABLE IF EXISTS `point_records`;
CREATE TABLE `point_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `rule_id` bigint unsigned DEFAULT NULL COMMENT '规则ID',
  `type` tinyint NOT NULL COMMENT '类型：1-增加，2-扣除',
  `points` int NOT NULL COMMENT '积分数量',
  `balance` bigint NOT NULL COMMENT '操作后余额',
  `source` varchar(50) NOT NULL COMMENT '来源：sign_in-签到，task-任务，consume-消费等',
  `source_id` varchar(100) DEFAULT NULL COMMENT '来源ID（关联业务ID）',
  `description` varchar(255) DEFAULT NULL COMMENT '描述说明',
  `related_id` bigint DEFAULT NULL COMMENT '关联业务ID',
  `operator_id` bigint DEFAULT NULL COMMENT '操作人ID（管理员ID）',
  `operator_type` tinyint DEFAULT NULL COMMENT '操作人类型：1-管理员，2-系统',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-已撤销，1-正常',
  `revoke_reason` varchar(255) DEFAULT NULL COMMENT '撤销原因',
  `revoke_time` timestamp NULL DEFAULT NULL COMMENT '撤销时间',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '过期时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_rule_id` (`rule_id`),
  KEY `idx_source` (`source`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_operator_id` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分记录表';

-- ===================================================
-- 5. 管理员表
-- ===================================================
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `is_super` tinyint NOT NULL DEFAULT '0' COMMENT '是否超级管理员：0-否，1-是',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表';

-- ===================================================
-- 6. 角色表
-- ===================================================
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `code` varchar(50) NOT NULL COMMENT '角色编码',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ===================================================
-- 7. 权限表
-- ===================================================
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(50) NOT NULL COMMENT '权限名称',
  `code` varchar(50) NOT NULL COMMENT '权限编码',
  `type` tinyint NOT NULL COMMENT '类型：1-菜单，2-按钮',
  `path` varchar(255) DEFAULT NULL COMMENT '路由路径',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `hidden` tinyint NOT NULL DEFAULT '0' COMMENT '是否隐藏：0-否，1-是',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';

-- ===================================================
-- 8. 角色权限关联表
-- ===================================================
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` bigint unsigned NOT NULL COMMENT '角色ID',
  `permission_id` bigint unsigned NOT NULL COMMENT '权限ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_permission` (`role_id`,`permission_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

-- ===================================================
-- 9. 管理员角色关联表
-- ===================================================
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` bigint unsigned NOT NULL COMMENT '管理员ID',
  `role_id` bigint unsigned NOT NULL COMMENT '角色ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_admin_role` (`admin_id`,`role_id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员角色关联表';

-- ===================================================
-- 10. 操作日志表
-- ===================================================
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint unsigned NOT NULL COMMENT '操作人ID',
  `user_type` tinyint NOT NULL COMMENT '操作人类型：1-管理员，2-用户',
  `username` varchar(50) DEFAULT NULL COMMENT '操作人用户名',
  `module` varchar(50) NOT NULL COMMENT '模块',
  `action` varchar(50) NOT NULL COMMENT '操作',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `method` varchar(10) DEFAULT NULL COMMENT '请求方法',
  `url` varchar(255) DEFAULT NULL COMMENT '请求URL',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '用户代理',
  `request_data` json DEFAULT NULL COMMENT '请求数据',
  `response_code` int DEFAULT NULL COMMENT '响应状态码',
  `response_data` json DEFAULT NULL COMMENT '响应数据',
  `execute_time` int DEFAULT NULL COMMENT '执行时间(ms)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_type` (`user_type`),
  KEY `idx_module` (`module`),
  KEY `idx_action` (`action`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志表';

-- ===================================================
-- 11. 积分等级表
-- ===================================================
DROP TABLE IF EXISTS `point_levels`;
CREATE TABLE `point_levels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `level` int NOT NULL COMMENT '等级',
  `name` varchar(50) NOT NULL COMMENT '等级名称',
  `min_points` bigint NOT NULL COMMENT '所需最小积分',
  `max_points` bigint DEFAULT NULL COMMENT '所需最大积分',
  `icon` varchar(255) DEFAULT NULL COMMENT '等级图标',
  `color` varchar(20) DEFAULT NULL COMMENT '等级颜色',
  `benefits` json DEFAULT NULL COMMENT '等级权益（JSON格式）',
  `description` text COMMENT '等级描述',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_level` (`level`),
  KEY `idx_min_points` (`min_points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='积分等级表';

-- ===================================================
-- 12. 签到记录表
-- ===================================================
DROP TABLE IF EXISTS `sign_in_records`;
CREATE TABLE `sign_in_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `sign_date` date NOT NULL COMMENT '签到日期',
  `points` int NOT NULL DEFAULT '0' COMMENT '获得积分',
  `continuous_days` int NOT NULL DEFAULT '1' COMMENT '连续签到天数',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_date` (`user_id`,`sign_date`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_sign_date` (`sign_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签到记录表';

-- ===================================================
-- 13. 系统配置表
-- ===================================================
DROP TABLE IF EXISTS `system_configs`;
CREATE TABLE `system_configs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `group` varchar(50) NOT NULL COMMENT '配置分组',
  `key` varchar(50) NOT NULL COMMENT '配置键',
  `value` text COMMENT '配置值',
  `type` varchar(20) NOT NULL DEFAULT 'string' COMMENT '值类型：string-字符串，int-整数，bool-布尔，json-JSON',
  `description` varchar(255) DEFAULT NULL COMMENT '配置描述',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_key` (`group`,`key`),
  KEY `idx_group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- ===================================================
-- 初始化数据
-- ===================================================

-- 插入默认管理员 (用户名: admin, 密码: admin123)
INSERT INTO `admins` (`username`, `password`, `nickname`, `status`, `is_super`) 
VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '超级管理员', 1, 1);

-- 插入默认积分等级
INSERT INTO `point_levels` (`level`, `name`, `min_points`, `max_points`, `icon`, `color`, `description`, `sort`) VALUES
(1, '铜牌会员', 0, 999, NULL, '#CD7F32', '新注册用户默认等级', 1),
(2, '银牌会员', 1000, 4999, NULL, '#C0C0C0', '累计积分达到1000分', 2),
(3, '金牌会员', 5000, 9999, NULL, '#FFD700', '累计积分达到5000分', 3),
(4, '白金会员', 10000, 49999, NULL, '#E5E4E2', '累计积分达到10000分', 4),
(5, '钻石会员', 50000, NULL, NULL, '#B9F2FF', '累计积分达到50000分', 5);

-- 插入默认积分规则
INSERT INTO `point_rules` (`name`, `code`, `type`, `points`, `description`, `priority`, `status`) VALUES
('每日签到', 'daily_sign_in', 'sign_in', 10, '每日首次签到奖励10积分', 10, 1),
('连续签到7天', 'continuous_7_days', 'sign_in', 50, '连续签到7天额外奖励50积分', 9, 1),
('连续签到30天', 'continuous_30_days', 'sign_in', 200, '连续签到30天额外奖励200积分', 8, 1);

-- 插入默认权限
INSERT INTO `permissions` (`parent_id`, `name`, `code`, `type`, `path`, `icon`, `sort`, `status`) VALUES
(0, '系统管理', 'system', 1, '/system', 'setting', 100, 1),
(0, '用户管理', 'user', 1, '/user', 'user', 90, 1),
(0, '积分管理', 'point', 1, '/point', 'money', 80, 1),
(2, '用户列表', 'user:list', 2, NULL, NULL, 1, 1),
(2, '添加用户', 'user:add', 2, NULL, NULL, 2, 1),
(2, '编辑用户', 'user:edit', 2, NULL, NULL, 3, 1),
(2, '删除用户', 'user:delete', 2, NULL, NULL, 4, 1),
(3, '积分规则', 'point:rule', 2, NULL, NULL, 1, 1),
(3, '积分记录', 'point:record', 2, NULL, NULL, 2, 1),
(3, '发放积分', 'point:grant', 2, NULL, NULL, 3, 1),
(3, '统计报表', 'point:statistics', 2, NULL, NULL, 4, 1);

-- 插入默认角色
INSERT INTO `roles` (`name`, `code`, `description`, `status`) VALUES
('超级管理员', 'super_admin', '拥有所有权限', 1),
('运营管理员', 'operator', '负责日常运营管理', 1);

-- 插入系统配置
INSERT INTO `system_configs` (`group`, `key`, `value`, `type`, `description`, `sort`) VALUES
('basic', 'system_name', '积分管理系统', 'string', '系统名称', 1),
('basic', 'system_version', '1.0.0', 'string', '系统版本', 2),
('point', 'enable_expire', '0', 'bool', '是否启用积分过期', 1),
('point', 'expire_days', '365', 'int', '积分过期天数', 2),
('point', 'min_grant_points', '1', 'int', '最小发放积分', 3),
('point', 'max_grant_points', '10000', 'int', '最大发放积分', 4);

-- ===================================================
-- 创建视图
-- ===================================================

-- 用户积分统计视图
CREATE OR REPLACE VIEW `v_user_point_statistics` AS
SELECT 
    u.id AS user_id,
    u.username,
    u.nickname,
    pa.available_points,
    pa.level,
    pl.name AS level_name,
    (SELECT COUNT(*) FROM point_records WHERE user_id = u.id AND type = 1 AND status = 1) AS earned_count,
    (SELECT COALESCE(SUM(points), 0) FROM point_records WHERE user_id = u.id AND type = 1 AND status = 1) AS total_earned,
    (SELECT COALESCE(SUM(points), 0) FROM point_records WHERE user_id = u.id AND type = 2 AND status = 1) AS total_spent
FROM users u
LEFT JOIN point_accounts pa ON u.id = pa.user_id
LEFT JOIN point_levels pl ON pa.level = pl.level
WHERE u.deleted_at IS NULL;

-- ===================================================
-- 创建存储过程
-- ===================================================

DELIMITER $$

-- 积分发放存储过程
CREATE PROCEDURE `sp_grant_points`(
    IN p_user_id BIGINT,
    IN p_points INT,
    IN p_rule_id BIGINT,
    IN p_source VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_operator_id BIGINT,
    OUT p_result INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_current_points BIGINT DEFAULT 0;
    DECLARE v_new_points BIGINT;
    DECLARE v_version INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_result = 0;
        SET p_message = '积分发放失败';
    END;
    
    START TRANSACTION;
    
    -- 获取当前积分（加锁）
    SELECT available_points, version INTO v_current_points, v_version
    FROM point_accounts 
    WHERE user_id = p_user_id 
    FOR UPDATE;
    
    -- 如果账户不存在，创建账户
    IF v_current_points IS NULL THEN
        INSERT INTO point_accounts (user_id, total_points, available_points, version)
        VALUES (p_user_id, 0, 0, 0);
        SET v_current_points = 0;
        SET v_version = 0;
    END IF;
    
    -- 计算新积分
    SET v_new_points = v_current_points + p_points;
    
    -- 更新账户（乐观锁）
    UPDATE point_accounts 
    SET available_points = v_new_points,
        total_points = total_points + p_points,
        version = version + 1
    WHERE user_id = p_user_id AND version = v_version;
    
    IF ROW_COUNT() = 0 THEN
        ROLLBACK;
        SET p_result = 0;
        SET p_message = '积分发放失败，请重试';
    ELSE
        -- 插入积分记录
        INSERT INTO point_records (
            user_id, rule_id, type, points, balance, 
            source, description, operator_id, operator_type, status
        ) VALUES (
            p_user_id, p_rule_id, 1, p_points, v_new_points,
            p_source, p_description, p_operator_id, 1, 1
        );
        
        COMMIT;
        SET p_result = 1;
        SET p_message = '积分发放成功';
    END IF;
END$$

DELIMITER ;

-- ===================================================
-- 索引优化建议
-- ===================================================
-- 
-- 1. point_records表数据量大时，考虑按月份分区
-- ALTER TABLE point_records PARTITION BY RANGE (TO_DAYS(created_at)) (
--     PARTITION p202401 VALUES LESS THAN (TO_DAYS('2024-02-01')),
--     ...
-- );
--
-- 2. operation_logs表建议定期归档历史数据
-- 
-- 3. 考虑为高频查询添加覆盖索引
-- 
-- ===================================================
