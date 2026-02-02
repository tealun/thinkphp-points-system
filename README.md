# ThinkPHP积分管理系统

一款基于ThinkPHP 8.0的积分管理系统，采用前后端分离架构，主要用于管理类奖励型积分（非积分商城）。

## ✨ 系统特点

- 🎯 **灵活的积分规则** - 支持签到、任务、消费等多种积分获取方式
- 📊 **完善的统计报表** - 提供多维度的数据统计和分析
- 👥 **用户分级管理** - 根据积分自动划分用户等级
- 🔐 **权限管理系统** - 基于RBAC的细粒度权限控制
- 📱 **响应式设计** - 支持PC端和移动端访问
- 🚀 **高性能架构** - Redis缓存 + MySQL优化，支持高并发

## 🛠️ 技术栈

### 后端
- ThinkPHP 8.0
- MySQL 8.0+
- Redis
- JWT认证

### 前端
- Vue 3 + TypeScript
- Element Plus / Ant Design Vue
- Pinia状态管理
- Vite构建工具
- ECharts图表

## 📋 主要功能

### 用户管理
- 用户列表查询（支持搜索、筛选、分页）
- 用户信息管理（增删改查）
- 用户批量导入导出
- 用户状态管理

### 积分规则管理
- 规则创建与配置
- 规则类型：签到、任务、消费、推荐、升级等
- 规则生效时间控制
- 规则优先级管理
- 规则启用/禁用

### 积分记录管理
- 积分发放（单个/批量）
- 积分扣除
- 积分记录查询（多维度筛选）
- 积分流水导出
- 积分撤销功能

### 统计报表
- 数据概览Dashboard
- 积分发放/消耗统计
- 用户积分排行榜
- 积分规则使用统计
- 用户活跃度分析
- 自定义报表生成

### 权限管理
- 角色管理
- 权限管理
- 角色权限分配
- 菜单权限控制

### 系统管理
- 操作日志
- 系统配置
- 数据字典

## 📂 项目文档

- [开发规划](./DEVELOPMENT_PLAN.md) - 详细的前后端开发计划
- [项目结构](./PROJECT_STRUCTURE.md) - 完整的目录结构说明
- [API设计](./API_DESIGN.md) - RESTful API接口文档
- [快速开始](./QUICK_START.md) - 环境搭建和安装指南
- [数据库设计](./database.sql) - 完整的数据库表结构

## 🚀 快速开始

### 环境要求
- PHP >= 8.1
- MySQL >= 8.0
- Redis >= 5.0
- Node.js >= 18.0

### 后端安装

```bash
# 克隆项目
git clone https://github.com/tealun/thinkphp-points-system.git
cd thinkphp-points-system

# 安装ThinkPHP（后续步骤）
cd backend
composer install

# 配置环境变量
cp .env.example .env
# 编辑.env配置数据库连接

# 导入数据库
mysql -u root -p < ../database.sql

# 启动服务
php think run
```

### 前端安装

```bash
# 进入前端目录
cd frontend/admin

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

详细安装步骤请查看 [快速开始指南](./QUICK_START.md)

## 📊 系统截图

_系统界面截图待补充_

## 🗓️ 开发计划

### 第一阶段：基础设施（1-2周）
- [x] 项目初始化
- [x] 数据库设计
- [x] API接口设计
- [x] 开发文档编写
- [ ] 后端框架搭建
- [ ] 前端框架搭建

### 第二阶段：核心功能（3-4周）
- [ ] 用户管理模块
- [ ] 积分账户管理
- [ ] 积分规则管理
- [ ] 积分记录管理

### 第三阶段：扩展功能（2-3周）
- [ ] 统计报表功能
- [ ] 权限管理系统
- [ ] 操作日志功能
- [ ] 数据导入导出

### 第四阶段：优化完善（1-2周）
- [ ] 性能优化
- [ ] 安全加固
- [ ] 测试覆盖
- [ ] 文档完善

查看详细规划：[开发规划文档](./DEVELOPMENT_PLAN.md)

## 📝 API文档

系统提供完整的RESTful API，支持以下功能：

- 用户认证（登录、退出、Token刷新）
- 用户管理CRUD操作
- 积分规则配置
- 积分发放/扣除
- 统计报表查询

详细接口文档请查看：[API设计文档](./API_DESIGN.md)

## 🔒 安全特性

- JWT Token身份认证
- 密码加密存储
- 接口请求频率限制
- XSS/SQL注入防护
- 操作日志审计
- 数据权限控制

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

1. Fork本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

## 📄 开源协议

本项目采用 MIT 协议，详见 [LICENSE](./LICENSE) 文件

## 💬 联系方式

- 提交Issue: [GitHub Issues](https://github.com/tealun/thinkphp-points-system/issues)
- 项目主页: [GitHub Repository](https://github.com/tealun/thinkphp-points-system)

## 🙏 鸣谢

感谢以下开源项目：

- [ThinkPHP](https://www.thinkphp.cn/)
- [Vue.js](https://vuejs.org/)
- [Element Plus](https://element-plus.org/)
- [ECharts](https://echarts.apache.org/)

---

⭐ 如果这个项目对你有帮助，请给个Star支持一下！
