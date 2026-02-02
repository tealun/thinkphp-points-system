# 积分系统项目结构

## 后端目录结构（ThinkPHP）

```
backend/
├── app/                          # 应用目录
│   ├── admin/                    # 管理后台模块
│   │   ├── controller/           # 控制器
│   │   │   ├── Auth.php         # 认证控制器
│   │   │   ├── User.php         # 用户管理
│   │   │   ├── PointRule.php    # 积分规则管理
│   │   │   ├── PointRecord.php  # 积分记录管理
│   │   │   ├── Statistics.php   # 统计报表
│   │   │   ├── Role.php         # 角色管理
│   │   │   └── Permission.php   # 权限管理
│   │   ├── model/               # 模型
│   │   │   ├── Admin.php
│   │   │   ├── User.php
│   │   │   ├── PointAccount.php
│   │   │   ├── PointRule.php
│   │   │   ├── PointRecord.php
│   │   │   ├── Role.php
│   │   │   ├── Permission.php
│   │   │   └── OperationLog.php
│   │   ├── validate/            # 验证器
│   │   │   ├── UserValidate.php
│   │   │   ├── PointRuleValidate.php
│   │   │   └── PointRecordValidate.php
│   │   ├── service/             # 服务层
│   │   │   ├── UserService.php
│   │   │   ├── PointService.php
│   │   │   ├── RuleService.php
│   │   │   └── StatisticsService.php
│   │   └── middleware/          # 中间件
│   │       ├── Auth.php
│   │       ├── Permission.php
│   │       └── OperationLog.php
│   │
│   ├── api/                     # API模块（用户端）
│   │   ├── controller/
│   │   │   ├── Auth.php
│   │   │   ├── Point.php
│   │   │   ├── User.php
│   │   │   └── Task.php
│   │   ├── model/
│   │   ├── validate/
│   │   └── middleware/
│   │
│   ├── common/                  # 公共模块
│   │   ├── exception/           # 异常处理
│   │   ├── library/             # 类库
│   │   ├── service/             # 公共服务
│   │   └── enum/                # 枚举类
│   │
│   ├── command/                 # 命令行
│   │   ├── PointExpire.php     # 积分过期处理
│   │   ├── StatisticsTask.php  # 统计任务
│   │   └── DataArchive.php     # 数据归档
│   │
│   └── event/                   # 事件
│       └── PointEvent.php
│
├── config/                      # 配置目录
│   ├── app.php                 # 应用配置
│   ├── database.php            # 数据库配置
│   ├── cache.php               # 缓存配置
│   ├── jwt.php                 # JWT配置
│   └── points.php              # 积分系统配置
│
├── database/                    # 数据库目录
│   ├── migrations/             # 数据迁移
│   └── seeds/                  # 数据填充
│
├── public/                     # 公开目录
│   ├── index.php              # 入口文件
│   └── uploads/               # 上传文件
│
├── runtime/                    # 运行时目录
│   ├── cache/
│   └── log/
│
├── vendor/                     # 依赖包
├── .env                       # 环境配置
├── .env.example              # 环境配置示例
├── composer.json             # Composer配置
└── think                     # 命令行工具
```

## 前端目录结构（Vue 3）

```
frontend/
├── admin/                      # 管理后台前端
│   ├── src/
│   │   ├── api/               # API接口
│   │   │   ├── auth.ts
│   │   │   ├── user.ts
│   │   │   ├── point.ts
│   │   │   ├── rule.ts
│   │   │   ├── statistics.ts
│   │   │   └── system.ts
│   │   │
│   │   ├── assets/            # 静态资源
│   │   │   ├── images/
│   │   │   ├── styles/
│   │   │   └── fonts/
│   │   │
│   │   ├── components/        # 组件
│   │   │   ├── common/       # 通用组件
│   │   │   │   ├── Header.vue
│   │   │   │   ├── Sidebar.vue
│   │   │   │   ├── Breadcrumb.vue
│   │   │   │   └── Pagination.vue
│   │   │   ├── user/         # 用户相关组件
│   │   │   │   ├── UserList.vue
│   │   │   │   ├── UserForm.vue
│   │   │   │   └── UserDetail.vue
│   │   │   ├── point/        # 积分相关组件
│   │   │   │   ├── PointRecordList.vue
│   │   │   │   ├── PointForm.vue
│   │   │   │   └── PointChart.vue
│   │   │   └── rule/         # 规则相关组件
│   │   │       ├── RuleList.vue
│   │   │       ├── RuleForm.vue
│   │   │       └── RuleCard.vue
│   │   │
│   │   ├── layouts/           # 布局
│   │   │   ├── DefaultLayout.vue
│   │   │   ├── EmptyLayout.vue
│   │   │   └── components/
│   │   │
│   │   ├── router/            # 路由
│   │   │   ├── index.ts
│   │   │   ├── modules/
│   │   │   │   ├── user.ts
│   │   │   │   ├── point.ts
│   │   │   │   ├── rule.ts
│   │   │   │   └── system.ts
│   │   │   └── guards.ts
│   │   │
│   │   ├── stores/            # 状态管理
│   │   │   ├── user.ts
│   │   │   ├── app.ts
│   │   │   └── permission.ts
│   │   │
│   │   ├── utils/             # 工具函数
│   │   │   ├── request.ts    # HTTP请求封装
│   │   │   ├── auth.ts       # 认证工具
│   │   │   ├── storage.ts    # 存储工具
│   │   │   ├── validate.ts   # 验证工具
│   │   │   └── format.ts     # 格式化工具
│   │   │
│   │   ├── views/             # 页面视图
│   │   │   ├── login/
│   │   │   │   └── index.vue
│   │   │   ├── dashboard/
│   │   │   │   └── index.vue
│   │   │   ├── user/
│   │   │   │   ├── index.vue
│   │   │   │   ├── detail.vue
│   │   │   │   └── import.vue
│   │   │   ├── point/
│   │   │   │   ├── record/
│   │   │   │   │   └── index.vue
│   │   │   │   ├── grant/
│   │   │   │   │   └── index.vue
│   │   │   │   └── adjust/
│   │   │   │       └── index.vue
│   │   │   ├── rule/
│   │   │   │   ├── index.vue
│   │   │   │   ├── create.vue
│   │   │   │   └── edit.vue
│   │   │   ├── statistics/
│   │   │   │   ├── overview.vue
│   │   │   │   ├── point.vue
│   │   │   │   └── report.vue
│   │   │   └── system/
│   │   │       ├── role/
│   │   │       ├── permission/
│   │   │       └── log/
│   │   │
│   │   ├── types/             # TypeScript类型定义
│   │   │   ├── api.d.ts
│   │   │   ├── user.d.ts
│   │   │   ├── point.d.ts
│   │   │   └── common.d.ts
│   │   │
│   │   ├── App.vue           # 根组件
│   │   └── main.ts           # 入口文件
│   │
│   ├── public/               # 公共资源
│   ├── .env                 # 环境变量
│   ├── .env.development    # 开发环境
│   ├── .env.production     # 生产环境
│   ├── index.html          # HTML模板
│   ├── package.json        # 依赖配置
│   ├── tsconfig.json       # TS配置
│   ├── vite.config.ts      # Vite配置
│   └── .eslintrc.js        # ESLint配置
│
├── user/                    # 用户端前端（可选）
│   ├── src/
│   │   ├── api/
│   │   ├── components/
│   │   ├── views/
│   │   │   ├── point/
│   │   │   │   ├── index.vue      # 积分主页
│   │   │   │   ├── detail.vue     # 积分明细
│   │   │   │   └── rule.vue       # 积分规则
│   │   │   └── task/
│   │   │       └── index.vue      # 任务中心
│   │   └── main.ts
│   └── ...
│
└── mobile/                 # 移动端H5（可选）
    └── ...
```

## 文档目录结构

```
docs/
├── api/                    # API文档
│   ├── admin/             # 管理端API
│   │   ├── auth.md
│   │   ├── user.md
│   │   ├── point.md
│   │   └── rule.md
│   └── user/              # 用户端API
│       ├── auth.md
│       └── point.md
│
├── database/              # 数据库文档
│   ├── schema.md         # 表结构设计
│   └── dictionary.md     # 数据字典
│
├── deploy/               # 部署文档
│   ├── environment.md    # 环境要求
│   ├── install.md        # 安装指南
│   └── upgrade.md        # 升级指南
│
├── development/          # 开发文档
│   ├── setup.md         # 开发环境搭建
│   ├── standard.md      # 开发规范
│   └── workflow.md      # 开发流程
│
└── user-manual/         # 用户手册
    ├── admin.md         # 管理员手册
    └── user.md          # 用户手册
```

## 测试目录结构

```
tests/
├── backend/
│   ├── unit/              # 单元测试
│   │   ├── service/
│   │   ├── model/
│   │   └── library/
│   ├── feature/           # 功能测试
│   │   ├── user/
│   │   ├── point/
│   │   └── rule/
│   └── integration/       # 集成测试
│
└── frontend/
    ├── unit/              # 组件单元测试
    └── e2e/               # 端到端测试
```

## 配置文件目录

```
config/
├── .env.example          # 环境变量示例
├── docker-compose.yml    # Docker配置
├── nginx.conf            # Nginx配置
├── php.ini               # PHP配置
└── supervisor.conf       # 进程管理配置
```

## CI/CD目录

```
.github/
└── workflows/
    ├── backend-test.yml  # 后端测试
    ├── frontend-test.yml # 前端测试
    └── deploy.yml        # 部署流程
```
