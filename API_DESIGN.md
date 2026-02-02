# API接口设计文档

## 接口规范

### 请求规范
- 接口地址：`http://domain.com/api/v1/`
- 请求方式：支持GET、POST、PUT、DELETE
- 请求头：
  - `Content-Type: application/json`
  - `Authorization: Bearer {token}`
  - `Accept-Language: zh-CN`

### 响应规范

#### 成功响应格式
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {},
  "timestamp": 1234567890
}
```

#### 失败响应格式
```json
{
  "code": 400,
  "message": "错误信息",
  "errors": {},
  "timestamp": 1234567890
}
```

#### 状态码说明
- `200`: 成功
- `201`: 创建成功
- `400`: 请求参数错误
- `401`: 未授权
- `403`: 无权限
- `404`: 资源不存在
- `422`: 验证失败
- `500`: 服务器错误

### 分页响应格式
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "list": [],
    "pagination": {
      "total": 100,
      "current_page": 1,
      "per_page": 20,
      "last_page": 5
    }
  }
}
```

---

## 一、认证接口

### 1.1 管理员登录
**接口地址**: `POST /admin/auth/login`

**请求参数**:
```json
{
  "username": "admin",
  "password": "123456",
  "captcha": "abcd"
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expires_in": 7200,
    "admin": {
      "id": 1,
      "username": "admin",
      "nickname": "管理员",
      "avatar": "https://...",
      "permissions": ["user:view", "user:edit"]
    }
  }
}
```

### 1.2 管理员退出
**接口地址**: `POST /admin/auth/logout`

**请求头**: `Authorization: Bearer {token}`

**响应数据**:
```json
{
  "code": 200,
  "message": "退出成功"
}
```

### 1.3 刷新Token
**接口地址**: `POST /admin/auth/refresh`

**请求头**: `Authorization: Bearer {token}`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "token": "new_token_string",
    "expires_in": 7200
  }
}
```

### 1.4 获取当前管理员信息
**接口地址**: `GET /admin/auth/info`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员",
    "avatar": "https://...",
    "email": "admin@example.com",
    "roles": ["超级管理员"],
    "permissions": ["*"]
  }
}
```

---

## 二、用户管理接口

### 2.1 用户列表
**接口地址**: `GET /admin/user/list`

**请求参数**:
```
?page=1
&per_page=20
&keyword=张三           // 搜索关键词（用户名/手机号/邮箱）
&status=1              // 状态筛选
&start_time=2024-01-01 // 开始时间
&end_time=2024-12-31   // 结束时间
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "username": "zhangsan",
        "nickname": "张三",
        "avatar": "https://...",
        "phone": "13800138000",
        "email": "zhangsan@example.com",
        "status": 1,
        "points": 1000,
        "level": 2,
        "created_at": "2024-01-01 10:00:00",
        "updated_at": "2024-01-01 10:00:00"
      }
    ],
    "pagination": {
      "total": 100,
      "current_page": 1,
      "per_page": 20,
      "last_page": 5
    }
  }
}
```

### 2.2 用户详情
**接口地址**: `GET /admin/user/{id}`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "id": 1,
    "username": "zhangsan",
    "nickname": "张三",
    "avatar": "https://...",
    "phone": "13800138000",
    "email": "zhangsan@example.com",
    "status": 1,
    "point_account": {
      "total_points": 1000,
      "available_points": 900,
      "frozen_points": 100,
      "level": 2
    },
    "statistics": {
      "total_earned": 1500,
      "total_spent": 500,
      "recent_records": []
    },
    "created_at": "2024-01-01 10:00:00",
    "updated_at": "2024-01-01 10:00:00"
  }
}
```

### 2.3 创建用户
**接口地址**: `POST /admin/user`

**请求参数**:
```json
{
  "username": "zhangsan",
  "password": "123456",
  "nickname": "张三",
  "phone": "13800138000",
  "email": "zhangsan@example.com",
  "status": 1
}
```

**响应数据**:
```json
{
  "code": 201,
  "message": "创建成功",
  "data": {
    "id": 1
  }
}
```

### 2.4 更新用户
**接口地址**: `PUT /admin/user/{id}`

**请求参数**:
```json
{
  "nickname": "张三丰",
  "phone": "13800138001",
  "email": "zhangsan@example.com",
  "status": 1
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "更新成功"
}
```

### 2.5 删除用户
**接口地址**: `DELETE /admin/user/{id}`

**响应数据**:
```json
{
  "code": 200,
  "message": "删除成功"
}
```

### 2.6 批量导入用户
**接口地址**: `POST /admin/user/import`

**请求参数**: FormData
- `file`: Excel文件

**响应数据**:
```json
{
  "code": 200,
  "message": "导入成功",
  "data": {
    "success": 100,
    "failed": 5,
    "errors": [
      {
        "row": 3,
        "reason": "用户名已存在"
      }
    ]
  }
}
```

### 2.7 导出用户
**接口地址**: `GET /admin/user/export`

**请求参数**: 与列表接口相同的筛选参数

**响应**: 返回Excel文件流

---

## 三、积分规则管理接口

### 3.1 规则列表
**接口地址**: `GET /admin/rule/list`

**请求参数**:
```
?page=1
&per_page=20
&type=sign_in  // 规则类型
&status=1      // 状态
&keyword=签到   // 搜索关键词
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "name": "每日签到",
        "code": "daily_sign_in",
        "type": "sign_in",
        "points": 10,
        "description": "每日首次签到奖励10积分",
        "priority": 1,
        "status": 1,
        "usage_count": 1000,
        "start_time": "2024-01-01 00:00:00",
        "end_time": null,
        "created_at": "2024-01-01 10:00:00"
      }
    ],
    "pagination": {
      "total": 20,
      "current_page": 1,
      "per_page": 20,
      "last_page": 1
    }
  }
}
```

### 3.2 规则详情
**接口地址**: `GET /admin/rule/{id}`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "id": 1,
    "name": "每日签到",
    "code": "daily_sign_in",
    "type": "sign_in",
    "points": 10,
    "description": "每日首次签到奖励10积分",
    "config": {
      "max_per_day": 1,
      "continuous_bonus": {
        "7": 5,
        "30": 20
      }
    },
    "priority": 1,
    "status": 1,
    "start_time": "2024-01-01 00:00:00",
    "end_time": null,
    "statistics": {
      "total_usage": 1000,
      "total_points": 10000,
      "today_usage": 50
    },
    "created_at": "2024-01-01 10:00:00",
    "updated_at": "2024-01-01 10:00:00"
  }
}
```

### 3.3 创建规则
**接口地址**: `POST /admin/rule`

**请求参数**:
```json
{
  "name": "每日签到",
  "code": "daily_sign_in",
  "type": "sign_in",
  "points": 10,
  "description": "每日首次签到奖励10积分",
  "config": {
    "max_per_day": 1
  },
  "priority": 1,
  "status": 1,
  "start_time": "2024-01-01 00:00:00",
  "end_time": null
}
```

**响应数据**:
```json
{
  "code": 201,
  "message": "创建成功",
  "data": {
    "id": 1
  }
}
```

### 3.4 更新规则
**接口地址**: `PUT /admin/rule/{id}`

**请求参数**: 同创建规则

**响应数据**:
```json
{
  "code": 200,
  "message": "更新成功"
}
```

### 3.5 删除规则
**接口地址**: `DELETE /admin/rule/{id}`

**响应数据**:
```json
{
  "code": 200,
  "message": "删除成功"
}
```

### 3.6 启用/禁用规则
**接口地址**: `PUT /admin/rule/{id}/status`

**请求参数**:
```json
{
  "status": 1  // 1-启用，0-禁用
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "操作成功"
}
```

### 3.7 规则类型列表
**接口地址**: `GET /admin/rule/types`

**响应数据**:
```json
{
  "code": 200,
  "data": [
    {
      "value": "sign_in",
      "label": "签到奖励",
      "description": "用户签到获得积分"
    },
    {
      "value": "task",
      "label": "任务奖励",
      "description": "完成任务获得积分"
    },
    {
      "value": "consume",
      "label": "消费奖励",
      "description": "消费金额获得积分"
    }
  ]
}
```

---

## 四、积分记录管理接口

### 4.1 积分记录列表
**接口地址**: `GET /admin/point/records`

**请求参数**:
```
?page=1
&per_page=20
&user_id=1          // 用户ID
&rule_id=1          // 规则ID
&type=1             // 类型：1-增加，2-扣除
&source=sign_in     // 来源
&start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "user_id": 1,
        "user": {
          "id": 1,
          "username": "zhangsan",
          "nickname": "张三"
        },
        "rule_id": 1,
        "rule": {
          "id": 1,
          "name": "每日签到"
        },
        "type": 1,
        "points": 10,
        "balance": 1010,
        "source": "sign_in",
        "description": "每日签到奖励",
        "operator_id": null,
        "status": 1,
        "created_at": "2024-01-01 10:00:00"
      }
    ],
    "pagination": {
      "total": 1000,
      "current_page": 1,
      "per_page": 20,
      "last_page": 50
    }
  }
}
```

### 4.2 积分记录详情
**接口地址**: `GET /admin/point/records/{id}`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "id": 1,
    "user_id": 1,
    "user": {
      "id": 1,
      "username": "zhangsan",
      "nickname": "张三",
      "avatar": "https://..."
    },
    "rule_id": 1,
    "rule": {
      "id": 1,
      "name": "每日签到",
      "code": "daily_sign_in"
    },
    "type": 1,
    "points": 10,
    "balance": 1010,
    "source": "sign_in",
    "description": "每日签到奖励",
    "related_id": null,
    "operator_id": null,
    "operator": null,
    "status": 1,
    "expire_time": null,
    "created_at": "2024-01-01 10:00:00"
  }
}
```

### 4.3 发放积分
**接口地址**: `POST /admin/point/grant`

**请求参数**:
```json
{
  "user_ids": [1, 2, 3],  // 用户ID数组
  "rule_id": 1,           // 规则ID（可选）
  "points": 100,          // 积分数量
  "description": "活动奖励",
  "expire_time": "2024-12-31 23:59:59"  // 过期时间（可选）
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "发放成功",
  "data": {
    "success": 3,
    "failed": 0,
    "total_points": 300
  }
}
```

### 4.4 扣除积分
**接口地址**: `POST /admin/point/deduct`

**请求参数**:
```json
{
  "user_id": 1,
  "points": 50,
  "description": "违规扣除"
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "扣除成功",
  "data": {
    "balance": 950
  }
}
```

### 4.5 撤销积分记录
**接口地址**: `POST /admin/point/records/{id}/revoke`

**请求参数**:
```json
{
  "reason": "误操作"
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "撤销成功"
}
```

### 4.6 导出积分记录
**接口地址**: `GET /admin/point/records/export`

**请求参数**: 与列表接口相同的筛选参数

**响应**: 返回Excel文件流

---

## 五、统计报表接口

### 5.1 数据概览
**接口地址**: `GET /admin/statistics/overview`

**请求参数**:
```
?start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "total_users": 10000,
    "active_users": 5000,
    "total_points_granted": 1000000,
    "total_points_deducted": 100000,
    "total_records": 50000,
    "today": {
      "new_users": 100,
      "active_users": 1000,
      "points_granted": 10000
    },
    "trend": {
      "users": [
        {"date": "2024-01-01", "count": 100},
        {"date": "2024-01-02", "count": 120}
      ],
      "points": [
        {"date": "2024-01-01", "granted": 1000, "deducted": 100},
        {"date": "2024-01-02", "granted": 1200, "deducted": 150}
      ]
    }
  }
}
```

### 5.2 积分发放统计
**接口地址**: `GET /admin/statistics/points`

**请求参数**:
```
?start_time=2024-01-01
&end_time=2024-12-31
&dimension=day  // 维度：day-日，week-周，month-月
&type=granted   // 类型：granted-发放，deducted-扣除
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "total": 1000000,
    "average": 33333,
    "chart": [
      {
        "date": "2024-01-01",
        "points": 10000,
        "records": 100
      },
      {
        "date": "2024-01-02",
        "points": 12000,
        "records": 120
      }
    ],
    "by_rule": [
      {
        "rule_id": 1,
        "rule_name": "每日签到",
        "points": 500000,
        "records": 50000,
        "percentage": 50
      }
    ]
  }
}
```

### 5.3 用户积分排行榜
**接口地址**: `GET /admin/statistics/ranking`

**请求参数**:
```
?page=1
&per_page=50
&type=total  // 类型：total-总积分，earned-获得积分
&start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "rank": 1,
        "user_id": 1,
        "username": "zhangsan",
        "nickname": "张三",
        "avatar": "https://...",
        "points": 10000,
        "level": 5
      }
    ],
    "pagination": {
      "total": 10000,
      "current_page": 1,
      "per_page": 50,
      "last_page": 200
    }
  }
}
```

### 5.4 积分规则使用统计
**接口地址**: `GET /admin/statistics/rules`

**请求参数**:
```
?start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": [
    {
      "rule_id": 1,
      "rule_name": "每日签到",
      "usage_count": 10000,
      "total_points": 100000,
      "unique_users": 5000,
      "average_points": 10,
      "trend": [
        {"date": "2024-01-01", "count": 100},
        {"date": "2024-01-02", "count": 120}
      ]
    }
  ]
}
```

### 5.5 用户活跃度分析
**接口地址**: `GET /admin/statistics/activity`

**请求参数**:
```
?start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "dau": 1000,
    "wau": 5000,
    "mau": 10000,
    "retention": {
      "day1": 80,
      "day7": 50,
      "day30": 30
    },
    "engagement": {
      "high": 1000,
      "medium": 3000,
      "low": 6000
    }
  }
}
```

---

## 六、权限管理接口

### 6.1 角色列表
**接口地址**: `GET /admin/role/list`

**响应数据**:
```json
{
  "code": 200,
  "data": [
    {
      "id": 1,
      "name": "超级管理员",
      "code": "super_admin",
      "description": "拥有所有权限",
      "status": 1,
      "admin_count": 1,
      "created_at": "2024-01-01 10:00:00"
    }
  ]
}
```

### 6.2 权限树
**接口地址**: `GET /admin/permission/tree`

**响应数据**:
```json
{
  "code": 200,
  "data": [
    {
      "id": 1,
      "name": "用户管理",
      "code": "user",
      "type": 1,
      "children": [
        {
          "id": 2,
          "name": "查看用户",
          "code": "user:view",
          "type": 2
        },
        {
          "id": 3,
          "name": "编辑用户",
          "code": "user:edit",
          "type": 2
        }
      ]
    }
  ]
}
```

### 6.3 分配权限
**接口地址**: `POST /admin/role/{id}/permissions`

**请求参数**:
```json
{
  "permission_ids": [1, 2, 3, 4]
}
```

**响应数据**:
```json
{
  "code": 200,
  "message": "分配成功"
}
```

---

## 七、用户端API接口

### 7.1 用户登录
**接口地址**: `POST /api/auth/login`

**请求参数**:
```json
{
  "username": "zhangsan",
  "password": "123456"
}
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "username": "zhangsan",
      "nickname": "张三",
      "avatar": "https://..."
    }
  }
}
```

### 7.2 获取我的积分
**接口地址**: `GET /api/point/my`

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "total_points": 1000,
    "available_points": 900,
    "frozen_points": 100,
    "level": 2,
    "level_name": "银牌会员",
    "next_level": {
      "level": 3,
      "name": "金牌会员",
      "required_points": 5000,
      "remaining_points": 4000
    }
  }
}
```

### 7.3 我的积分明细
**接口地址**: `GET /api/point/records`

**请求参数**:
```
?page=1
&per_page=20
&type=1  // 类型：1-增加，2-扣除
&start_time=2024-01-01
&end_time=2024-12-31
```

**响应数据**:
```json
{
  "code": 200,
  "data": {
    "list": [
      {
        "id": 1,
        "type": 1,
        "points": 10,
        "balance": 1010,
        "source": "sign_in",
        "description": "每日签到奖励",
        "created_at": "2024-01-01 10:00:00"
      }
    ],
    "pagination": {
      "total": 100,
      "current_page": 1,
      "per_page": 20,
      "last_page": 5
    }
  }
}
```

### 7.4 积分规则说明
**接口地址**: `GET /api/point/rules`

**响应数据**:
```json
{
  "code": 200,
  "data": [
    {
      "id": 1,
      "name": "每日签到",
      "type": "sign_in",
      "points": 10,
      "description": "每日首次签到奖励10积分",
      "icon": "https://..."
    }
  ]
}
```

### 7.5 签到
**接口地址**: `POST /api/point/sign-in`

**响应数据**:
```json
{
  "code": 200,
  "message": "签到成功",
  "data": {
    "points": 10,
    "continuous_days": 7,
    "total_sign_days": 30,
    "bonus_points": 5
  }
}
```

---

## 附录

### A. 错误码说明
| 错误码 | 说明 |
|--------|------|
| 10001 | 用户名或密码错误 |
| 10002 | Token已过期 |
| 10003 | Token无效 |
| 10004 | 无权限访问 |
| 20001 | 用户不存在 |
| 20002 | 用户已禁用 |
| 30001 | 积分不足 |
| 30002 | 规则不存在 |
| 30003 | 规则已禁用 |
| 30004 | 今日已签到 |
| 40001 | 参数验证失败 |
| 50001 | 系统错误 |

### B. 枚举值说明

#### 用户状态
- `0`: 禁用
- `1`: 正常

#### 积分记录类型
- `1`: 增加
- `2`: 扣除

#### 积分规则类型
- `sign_in`: 签到奖励
- `task`: 任务奖励
- `consume`: 消费奖励
- `referral`: 推荐奖励
- `upgrade`: 升级奖励
- `manual`: 手动调整
- `scheduled`: 定时发放

#### 记录状态
- `0`: 已撤销
- `1`: 正常

#### 权限类型
- `1`: 菜单
- `2`: 按钮
