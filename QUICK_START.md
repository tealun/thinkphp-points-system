# 快速开始指南

本文档将指导你如何快速搭建和启动ThinkPHP积分管理系统。

## 环境要求

### 后端环境
- PHP >= 8.1
- MySQL >= 8.0
- Redis >= 5.0
- Composer >= 2.0
- Nginx 或 Apache

### 前端环境
- Node.js >= 18.0
- npm >= 9.0 或 pnpm >= 8.0

## 一、后端安装

### 1. 创建项目

```bash
# 创建后端目录
mkdir backend
cd backend

# 安装ThinkPHP 8.0
composer create-project topthink/think .

# 或者使用国内镜像
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
composer create-project topthink/think .
```

### 2. 安装依赖包

```bash
# JWT认证
composer require firebase/php-jwt

# 图片处理
composer require intervention/image

# Excel导入导出
composer require phpoffice/phpspreadsheet

# Redis扩展
composer require predis/predis

# 验证码
composer require topthink/think-captcha

# API文档生成
composer require zircote/swagger-php
```

### 3. 配置数据库

编辑 `.env` 文件：

```ini
APP_DEBUG = true

[APP]
DEFAULT_TIMEZONE = Asia/Shanghai

[DATABASE]
TYPE = mysql
HOSTNAME = 127.0.0.1
DATABASE = points_system
USERNAME = root
PASSWORD = your_password
HOSTPORT = 3306
CHARSET = utf8mb4
DEBUG = true

[REDIS]
HOST = 127.0.0.1
PORT = 6379
PASSWORD = 
SELECT = 0

[JWT]
SECRET = your_jwt_secret_key
EXPIRE = 7200
REFRESH_EXPIRE = 864000
```

### 4. 导入数据库

```bash
# 登录MySQL
mysql -u root -p

# 导入数据库文件
mysql -u root -p < database.sql
```

### 5. 配置权限

```bash
# 设置runtime目录权限
chmod -R 777 runtime

# 设置public/uploads目录权限
mkdir -p public/uploads
chmod -R 777 public/uploads
```

### 6. 配置Nginx

创建Nginx配置文件 `/etc/nginx/sites-available/points-api`:

```nginx
server {
    listen 80;
    server_name api.points.local;
    root /path/to/backend/public;
    index index.php index.html;

    location / {
        if (!-e $request_filename) {
            rewrite ^(.*)$ /index.php?s=$1 last;
            break;
        }
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

启用配置：

```bash
sudo ln -s /etc/nginx/sites-available/points-api /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 7. 测试后端

```bash
# 启动PHP内置服务器（开发环境）
php think run

# 或者
php -S localhost:8080 -t public/
```

访问 `http://localhost:8080` 检查是否正常。

## 二、前端安装

### 1. 创建Vue项目

```bash
# 创建前端目录
mkdir frontend
cd frontend

# 使用Vite创建Vue3项目
npm create vite@latest admin -- --template vue-ts
cd admin

# 或使用pnpm
pnpm create vite admin --template vue-ts
cd admin
```

### 2. 安装依赖

```bash
# 安装基础依赖
npm install

# 安装UI组件库（Element Plus）
npm install element-plus @element-plus/icons-vue

# 或使用Ant Design Vue
# npm install ant-design-vue @ant-design/icons-vue

# 安装路由
npm install vue-router@4

# 安装状态管理
npm install pinia

# 安装HTTP客户端
npm install axios

# 安装图表库
npm install echarts vue-echarts

# 安装工具库
npm install lodash-es
npm install dayjs
npm install js-cookie

# 安装开发依赖
npm install -D @types/node
npm install -D @types/lodash-es
npm install -D unplugin-vue-components
npm install -D unplugin-auto-import
```

### 3. 配置环境变量

创建 `.env.development` 文件：

```env
# 开发环境
VITE_APP_TITLE=积分管理系统
VITE_APP_BASE_API=http://localhost:8080/api/v1
VITE_APP_UPLOAD_URL=http://localhost:8080/api/v1/upload
```

创建 `.env.production` 文件：

```env
# 生产环境
VITE_APP_TITLE=积分管理系统
VITE_APP_BASE_API=https://api.yourdomain.com/api/v1
VITE_APP_UPLOAD_URL=https://api.yourdomain.com/api/v1/upload
```

### 4. 配置Vite

编辑 `vite.config.ts`:

```typescript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'

export default defineConfig({
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  server: {
    port: 3000,
    open: true,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
})
```

### 5. 启动前端

```bash
# 开发模式
npm run dev

# 构建生产版本
npm run build

# 预览生产构建
npm run preview
```

## 三、Docker部署（可选）

### 1. 创建Dockerfile

**后端Dockerfile** (`backend/Dockerfile`):

```dockerfile
FROM php:8.1-fpm

# 安装依赖
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# 安装PHP扩展
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 安装Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 设置工作目录
WORKDIR /var/www

# 复制项目文件
COPY . .

# 安装项目依赖
RUN composer install --no-dev --optimize-autoloader

# 设置权限
RUN chown -R www-data:www-data /var/www

EXPOSE 9000

CMD ["php-fpm"]
```

**前端Dockerfile** (`frontend/admin/Dockerfile`):

```dockerfile
# 构建阶段
FROM node:18-alpine as build-stage

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# 生产阶段
FROM nginx:alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### 2. 创建docker-compose.yml

```yaml
version: '3.8'

services:
  # MySQL数据库
  mysql:
    image: mysql:8.0
    container_name: points_mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: points_system
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./database.sql:/docker-entrypoint-initdb.d/init.sql

  # Redis缓存
  redis:
    image: redis:7-alpine
    container_name: points_redis
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # PHP后端
  backend:
    build: ./backend
    container_name: points_backend
    restart: always
    volumes:
      - ./backend:/var/www
    depends_on:
      - mysql
      - redis

  # Nginx
  nginx:
    image: nginx:alpine
    container_name: points_nginx
    restart: always
    ports:
      - "8080:80"
    volumes:
      - ./backend/public:/var/www/public
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - backend

  # 前端
  frontend:
    build: ./frontend/admin
    container_name: points_frontend
    restart: always
    ports:
      - "80:80"
    depends_on:
      - nginx

volumes:
  mysql_data:
  redis_data:
```

### 3. 启动Docker服务

```bash
# 构建并启动所有服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down

# 停止并删除数据
docker-compose down -v
```

## 四、开发工具推荐

### IDE/编辑器
- **VS Code** (推荐)
  - PHP Intelephense
  - Vetur / Volar
  - ESLint
  - Prettier
  - GitLens

- **PhpStorm**
  - 专业PHP开发IDE

### API测试工具
- **Postman** - API接口测试
- **Apifox** - 国产API管理工具
- **Insomnia** - 轻量级API客户端

### 数据库管理
- **Navicat** - 专业数据库管理工具
- **MySQL Workbench** - MySQL官方工具
- **DBeaver** - 免费开源工具

### Git工具
- **GitKraken** - 图形化Git客户端
- **SourceTree** - 免费Git GUI
- **Git命令行** - 原生Git

## 五、常见问题

### 1. Composer安装慢怎么办？

使用国内镜像：

```bash
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
```

### 2. npm安装慢怎么办？

使用淘宝镜像：

```bash
npm config set registry https://registry.npmmirror.com
# 或使用pnpm
pnpm config set registry https://registry.npmmirror.com
```

### 3. 数据库连接失败？

检查：
- MySQL服务是否启动
- 数据库配置是否正确
- 防火墙是否开放3306端口
- PHP PDO扩展是否安装

### 4. 前端跨域问题？

开发环境使用Vite代理，生产环境配置Nginx：

```nginx
add_header Access-Control-Allow-Origin *;
add_header Access-Control-Allow-Methods 'GET, POST, PUT, DELETE, OPTIONS';
add_header Access-Control-Allow-Headers 'Authorization, Content-Type';
```

### 5. JWT Token认证失败？

检查：
- JWT密钥配置是否正确
- Token是否过期
- 请求头是否包含Authorization
- Token格式是否正确 (Bearer {token})

## 六、下一步

- 查看 [开发规划文档](./DEVELOPMENT_PLAN.md) 了解详细开发计划
- 查看 [API设计文档](./API_DESIGN.md) 了解接口定义
- 查看 [项目结构文档](./PROJECT_STRUCTURE.md) 了解目录结构
- 开始开发第一个模块

## 七、技术支持

如遇到问题，可以：
1. 查看项目文档
2. 提交Issue
3. 加入开发者群组
4. 查看ThinkPHP官方文档: https://www.kancloud.cn/manual/thinkphp8_0/
5. 查看Vue3官方文档: https://cn.vuejs.org/

祝开发顺利！ 🚀
