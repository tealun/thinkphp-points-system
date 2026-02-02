# ThinkPHP积分系统开发规划

## 项目概述
基于ThinkPHP 8.0开发的积分管理系统，采用前后端分离架构，主要用于管理类奖励型积分（非积分商城）。

## 技术栈选型

### 后端技术栈
- **框架**: ThinkPHP 8.0
- **数据库**: MySQL 8.0+
- **缓存**: Redis
- **PHP版本**: PHP 8.1+
- **API文档**: Swagger/OpenAPI
- **认证**: JWT Token

### 前端技术栈
- **框架**: Vue 3 + TypeScript
- **UI组件库**: Element Plus / Ant Design Vue
- **状态管理**: Pinia
- **路由**: Vue Router 4
- **HTTP客户端**: Axios
- **构建工具**: Vite
- **图表库**: ECharts

## 一、项目初始化阶段

### 1.1 后端初始化
- [ ] 安装ThinkPHP 8.0框架
- [ ] 配置数据库连接
- [ ] 配置Redis缓存
- [ ] 设置跨域CORS配置
- [ ] 配置JWT认证
- [ ] 创建基础目录结构
- [ ] 编写.gitignore文件
- [ ] 配置composer依赖

### 1.2 前端初始化
- [ ] 初始化Vue 3项目
- [ ] 安装UI组件库
- [ ] 配置路由系统
- [ ] 配置状态管理
- [ ] 配置API请求封装
- [ ] 创建基础布局组件
- [ ] 配置环境变量

### 1.3 数据库设计
- [ ] 用户表（users）
- [ ] 积分规则表（point_rules）
- [ ] 积分记录表（point_records）
- [ ] 积分账户表（point_accounts）
- [ ] 管理员表（admins）
- [ ] 角色权限表（roles、permissions）
- [ ] 操作日志表（operation_logs）

## 二、后端开发任务

### 2.1 用户管理模块
**优先级：高**

#### 功能点
- [ ] 用户注册接口
- [ ] 用户登录接口（支持多种方式）
- [ ] 用户信息查询接口
- [ ] 用户信息修改接口
- [ ] 用户列表查询接口（分页、搜索、筛选）
- [ ] 用户状态管理（启用/禁用）
- [ ] 用户批量导入
- [ ] 用户导出功能

#### 技术要点
- 密码加密存储
- Token刷新机制
- 登录日志记录
- 防暴力破解
- 数据验证

### 2.2 积分规则管理模块
**优先级：高**

#### 功能点
- [ ] 创建积分规则
- [ ] 编辑积分规则
- [ ] 删除积分规则
- [ ] 积分规则列表查询
- [ ] 积分规则详情查询
- [ ] 规则启用/禁用
- [ ] 规则生效时间设置
- [ ] 规则优先级管理

#### 规则类型
- 签到奖励
- 任务完成奖励
- 消费奖励
- 推荐奖励
- 等级升级奖励
- 手动调整
- 定时发放
- 扣除规则

#### 技术要点
- 规则配置灵活性
- 规则冲突检测
- 规则版本控制
- 规则生效策略

### 2.3 积分记录管理模块
**优先级：高**

#### 功能点
- [ ] 积分发放接口
- [ ] 积分扣除接口
- [ ] 积分记录查询（支持多维度筛选）
- [ ] 积分流水导出
- [ ] 积分撤销功能
- [ ] 批量积分发放
- [ ] 定时积分任务
- [ ] 积分过期处理

#### 查询维度
- 按用户查询
- 按时间范围查询
- 按积分类型查询
- 按操作人查询
- 按业务类型查询

#### 技术要点
- 事务处理确保数据一致性
- 积分计算准确性
- 并发控制
- 审计日志
- 数据归档策略

### 2.4 积分账户管理模块
**优先级：高**

#### 功能点
- [ ] 账户余额查询
- [ ] 账户明细查询
- [ ] 账户冻结/解冻
- [ ] 账户等级管理
- [ ] 积分有效期管理
- [ ] 账户统计信息

#### 技术要点
- 余额实时计算vs缓存
- 分布式锁防并发
- 数据一致性保证
- 性能优化

### 2.5 积分统计报表模块
**优先级：中**

#### 功能点
- [ ] 积分发放统计（日/周/月/年）
- [ ] 积分消耗统计
- [ ] 用户积分排行榜
- [ ] 积分规则使用统计
- [ ] 用户活跃度分析
- [ ] 自定义报表生成
- [ ] 报表导出（Excel/PDF）
- [ ] 数据可视化接口

#### 统计维度
- 时间维度
- 用户维度
- 规则维度
- 业务维度
- 地域维度

#### 技术要点
- 大数据量查询优化
- 统计数据缓存
- 异步报表生成
- 数据聚合策略

### 2.6 权限管理模块
**优先级：中**

#### 功能点
- [ ] 角色管理（CRUD）
- [ ] 权限管理（CRUD）
- [ ] 角色权限分配
- [ ] 用户角色分配
- [ ] 菜单权限控制
- [ ] 数据权限控制
- [ ] 操作权限验证

#### 技术要点
- RBAC权限模型
- 权限缓存机制
- 动态权限加载
- 细粒度权限控制

### 2.7 系统管理模块
**优先级：低**

#### 功能点
- [ ] 系统配置管理
- [ ] 操作日志查询
- [ ] 系统监控接口
- [ ] 数据字典管理
- [ ] 通知消息管理
- [ ] 定时任务管理
- [ ] 文件上传管理

### 2.8 API开发规范

#### 接口设计原则
- RESTful API设计
- 统一响应格式
- 统一错误码
- 接口版本控制
- 请求参数验证
- 响应数据格式化

#### 接口文档
- 使用Swagger/OpenAPI
- 接口分组管理
- 接口示例代码
- 接口变更记录

#### 安全性
- JWT Token认证
- 接口签名验证
- 请求频率限制
- XSS/SQL注入防护
- HTTPS传输

## 三、前端开发任务

### 3.1 管理后台开发
**优先级：高**

#### 3.1.1 用户管理界面
- [ ] 用户列表页面
  - 搜索框（用户名、手机号、邮箱）
  - 筛选器（状态、注册时间、用户等级）
  - 表格展示（分页）
  - 批量操作（导出、禁用）
- [ ] 用户详情页面
  - 基本信息展示
  - 积分账户信息
  - 积分明细列表
  - 操作记录
- [ ] 用户编辑页面
  - 表单验证
  - 信息修改
  - 密码重置
- [ ] 用户导入页面
  - Excel模板下载
  - 文件上传
  - 导入结果展示

#### 3.1.2 积分规则管理界面
- [ ] 规则列表页面
  - 规则卡片/列表展示
  - 规则分类筛选
  - 启用/禁用快捷操作
  - 规则优先级排序
- [ ] 规则创建/编辑页面
  - 规则类型选择
  - 规则参数配置（动态表单）
  - 生效时间设置
  - 规则描述编辑器
  - 规则预览
- [ ] 规则详情页面
  - 规则信息展示
  - 使用统计图表
  - 关联记录

#### 3.1.3 积分记录管理界面
- [ ] 积分记录列表
  - 多维度筛选（用户、时间、类型、状态）
  - 高级搜索
  - 记录详情查看
  - 批量导出
- [ ] 积分发放页面
  - 单个发放
  - 批量发放
  - 定时发放
  - 发放预览
- [ ] 积分调整页面
  - 手动增加/扣除
  - 调整原因说明
  - 审核流程（可选）

#### 3.1.4 统计报表界面
- [ ] 数据概览页面（Dashboard）
  - 关键指标卡片（总积分、活跃用户等）
  - 趋势图表（积分发放趋势）
  - 排行榜（用户积分排行）
  - 快捷操作入口
- [ ] 积分统计页面
  - 时间选择器
  - 多维度图表（折线图、柱状图、饼图）
  - 数据对比功能
  - 自定义时间范围
- [ ] 报表中心
  - 报表模板选择
  - 自定义报表生成
  - 报表下载
  - 历史报表查看

#### 3.1.5 系统管理界面
- [ ] 角色权限管理
  - 角色列表
  - 权限树配置
  - 角色分配
- [ ] 操作日志
  - 日志列表
  - 日志搜索
  - 日志详情
- [ ] 系统配置
  - 配置项管理
  - 参数设置

### 3.2 用户端开发
**优先级：中**

#### 3.2.1 积分查询界面
- [ ] 个人积分主页
  - 当前积分余额
  - 积分等级展示
  - 积分趋势图
  - 最近记录
- [ ] 积分明细页面
  - 收支记录列表
  - 按月份查看
  - 记录详情
  - 搜索筛选
- [ ] 积分规则说明页面
  - 规则列表展示
  - 规则详情说明
  - 获取方式指引

#### 3.2.2 任务中心（可选）
- [ ] 任务列表
- [ ] 任务详情
- [ ] 任务完成状态
- [ ] 任务奖励预览

### 3.3 移动端适配
**优先级：低**

#### 3.3.1 响应式设计
- [ ] 移动端布局适配
- [ ] 触摸手势支持
- [ ] 移动端组件优化

#### 3.3.2 H5页面（可选）
- [ ] 积分查询H5页面
- [ ] 签到H5页面
- [ ] 分享H5页面

### 3.4 前端技术要点

#### 3.4.1 组件化开发
- 封装通用业务组件
- 组件文档编写
- 组件单元测试

#### 3.4.2 状态管理
- 用户状态管理
- 权限状态管理
- 通用配置管理
- 缓存策略

#### 3.4.3 性能优化
- 路由懒加载
- 组件懒加载
- 图片懒加载
- 请求防抖节流
- 列表虚拟滚动
- 打包优化

#### 3.4.4 用户体验
- Loading状态提示
- 错误提示友好化
- 操作确认提示
- 表单验证提示
- 骨架屏加载
- 空状态设计

## 四、数据库设计详细方案

### 4.1 用户表（users）
```sql
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  KEY `idx_phone` (`phone`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
```

### 4.2 积分账户表（point_accounts）
```sql
CREATE TABLE `point_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `total_points` bigint NOT NULL DEFAULT '0' COMMENT '总积分',
  `available_points` bigint NOT NULL DEFAULT '0' COMMENT '可用积分',
  `frozen_points` bigint NOT NULL DEFAULT '0' COMMENT '冻结积分',
  `level` int NOT NULL DEFAULT '1' COMMENT '积分等级',
  `version` int NOT NULL DEFAULT '0' COMMENT '版本号（乐观锁）',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分账户表';
```

### 4.3 积分规则表（point_rules）
```sql
CREATE TABLE `point_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `name` varchar(100) NOT NULL COMMENT '规则名称',
  `code` varchar(50) NOT NULL COMMENT '规则编码',
  `type` varchar(20) NOT NULL COMMENT '规则类型：sign_in-签到，task-任务，consume-消费等',
  `points` int NOT NULL COMMENT '积分数量',
  `description` text COMMENT '规则描述',
  `config` json DEFAULT NULL COMMENT '规则配置（JSON）',
  `priority` int NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '生效开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '生效结束时间',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分规则表';
```

### 4.4 积分记录表（point_records）
```sql
CREATE TABLE `point_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `rule_id` bigint unsigned DEFAULT NULL COMMENT '规则ID',
  `type` tinyint NOT NULL COMMENT '类型：1-增加，2-扣除',
  `points` int NOT NULL COMMENT '积分数量',
  `balance` bigint NOT NULL COMMENT '操作后余额',
  `source` varchar(50) NOT NULL COMMENT '来源：sign_in-签到，task-任务等',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `related_id` bigint DEFAULT NULL COMMENT '关联业务ID',
  `operator_id` bigint DEFAULT NULL COMMENT '操作人ID',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-已撤销，1-正常',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '过期时间',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_rule_id` (`rule_id`),
  KEY `idx_source` (`source`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分记录表';
```

### 4.5 管理员表（admins）
```sql
CREATE TABLE `admins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';
```

### 4.6 角色表（roles）
```sql
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `code` varchar(50) NOT NULL COMMENT '角色编码',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
```

### 4.7 权限表（permissions）
```sql
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(50) NOT NULL COMMENT '权限名称',
  `code` varchar(50) NOT NULL COMMENT '权限编码',
  `type` tinyint NOT NULL COMMENT '类型：1-菜单，2-按钮',
  `path` varchar(255) DEFAULT NULL COMMENT '路由路径',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限表';
```

### 4.8 操作日志表（operation_logs）
```sql
CREATE TABLE `operation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint unsigned NOT NULL COMMENT '操作人ID',
  `user_type` tinyint NOT NULL COMMENT '操作人类型：1-管理员，2-用户',
  `module` varchar(50) NOT NULL COMMENT '模块',
  `action` varchar(50) NOT NULL COMMENT '操作',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `request_data` json DEFAULT NULL COMMENT '请求数据',
  `response_data` json DEFAULT NULL COMMENT '响应数据',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_module` (`module`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';
```

## 五、开发顺序建议

### 第一阶段：基础设施（1-2周）
1. 项目初始化（后端+前端）
2. 数据库设计与创建
3. 基础框架搭建
4. 开发环境配置
5. 代码规范制定

### 第二阶段：核心功能（3-4周）
1. 用户管理模块（后端+前端）
2. 积分账户管理（后端+前端）
3. 积分规则管理（后端+前端）
4. 积分记录管理（后端+前端）

### 第三阶段：扩展功能（2-3周）
1. 统计报表功能
2. 权限管理系统
3. 操作日志功能
4. 数据导入导出

### 第四阶段：优化完善（1-2周）
1. 性能优化
2. 安全加固
3. 测试覆盖
4. 文档完善

### 第五阶段：上线准备（1周）
1. 部署文档编写
2. 用户手册编写
3. 生产环境部署
4. 线上监控配置

## 六、技术难点与解决方案

### 6.1 并发控制
**问题**：积分增减操作的并发安全
**解决方案**：
- 使用数据库事务
- 乐观锁（version字段）
- Redis分布式锁
- 消息队列异步处理

### 6.2 性能优化
**问题**：大量积分记录查询性能
**解决方案**：
- 数据库索引优化
- 分表分库策略
- Redis缓存热点数据
- ES全文检索
- 数据归档

### 6.3 数据一致性
**问题**：积分账户与记录的一致性
**解决方案**：
- 强事务保证
- 定时对账任务
- 数据修复机制
- 审计日志

### 6.4 扩展性
**问题**：积分规则的灵活配置
**解决方案**：
- 规则引擎设计
- JSON配置方式
- 插件化架构
- 规则版本控制

## 七、质量保证

### 7.1 代码质量
- 代码审查机制
- 代码规范检查（PHP CS Fixer、ESLint）
- 单元测试覆盖
- 集成测试

### 7.2 接口测试
- Postman测试集
- 自动化接口测试
- 压力测试
- 安全测试

### 7.3 前端测试
- 组件单元测试
- E2E测试
- 浏览器兼容性测试
- 性能测试

## 八、部署与运维

### 8.1 部署方案
- Docker容器化部署
- CI/CD自动化部署
- 灰度发布策略
- 回滚方案

### 8.2 监控告警
- 应用性能监控
- 错误日志监控
- 业务指标监控
- 告警通知

### 8.3 备份恢复
- 数据库定时备份
- 代码版本管理
- 配置文件备份
- 灾难恢复方案

## 九、团队协作

### 9.1 开发流程
- Git Flow工作流
- 分支管理策略
- 代码提交规范
- PR审查流程

### 9.2 文档管理
- API接口文档
- 数据库文档
- 部署文档
- 开发规范文档
- 变更日志

### 9.3 项目管理
- 任务拆分
- 进度跟踪
- 风险管理
- 版本规划

## 十、时间估算

**总体开发周期**：8-10周

- 第一阶段：1-2周
- 第二阶段：3-4周
- 第三阶段：2-3周
- 第四阶段：1-2周
- 第五阶段：1周

**注**：以上时间估算基于2-3人的小团队，实际情况需根据团队规模和经验调整。
