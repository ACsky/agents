# Claude Code 插件安装指南

## 重要说明

斜杠命令（如 `/plugin install`）**只能在交互式 Claude 会话中使用**，不能通过命令行执行。

## 正确的安装方法

### 步骤 1：启动交互式 Claude 会话

```bash
claude
```

### 步骤 2：在交互式会话中逐个安装插件

一旦进入交互式会话，您可以逐个运行以下命令：

#### 核心开发插件
```bash
/plugin install python-development
/plugin install javascript-typescript
/plugin install backend-development
```

#### 代码质量和调试
```bash
/plugin install code-review-ai
/plugin install debugging-toolkit
/plugin install security-scanning
```

#### 更多实用插件
```bash
/plugin install unit-testing
/plugin install git-pr-workflows
/plugin install documentation-generation
/plugin install full-stack-orchestration
```

### 步骤 3：验证安装

安装完成后，使用以下命令查看可用的代理：

```bash
/agent
```

## 预期结果

安装这些插件后，您将能够访问：

### Python 开发插件 (`python-development`)
- **python-pro** - Python 专家代理
- **django-pro** - Django 专家代理
- **fastapi-pro** - FastAPI 专家代理
- **5 个专业技能**：异步模式、测试模式、打包、性能优化、UV 包管理器

### JavaScript/TypeScript 插件 (`javascript-typescript`)
- **javascript-pro** - JavaScript 专家代理
- **typescript-pro** - TypeScript 专家代理
- **4 个专业技能**：高级类型、Node.js 模式、测试、现代 ES6+

### 后端开发插件 (`backend-development`)
- **backend-architect** - 后端架构师代理
- **graphql-architect** - GraphQL 架构师代理
- **tdd-orchestrator** - TDD 编排器代理
- **3 个架构技能**：API 设计、架构模式、微服务

### 代码审查插件 (`code-review-ai`)
- **architect-review** - 架构审查代理

### 调试工具包 (`debugging-toolkit`)
- **debugger** - 调试器代理
- **dx-optimizer** - 开发体验优化器代理

### 安全扫描插件 (`security-scanning`)
- **security-auditor** - 安全审计员代理
- **SAST 配置技能**：静态应用安全测试配置

## 使用代理

安装完成后，您可以通过以下方式使用代理：

```bash
# 列出所有可用代理
/agent

# 使用特定代理
/agent python-pro
/agent backend-architect
/agent security-auditor
```

## 故障排除

如果 `/agent` 命令仍然显示没有代理：

1. **确认插件安装**：在交互式会话中运行 `/plugin` 查看已安装的插件
2. **重新安装**：尝试重新运行 `/plugin install [plugin-name]`
3. **检查市场**：确认市场已正确添加：`/plugin marketplace list`

## 批量安装建议

由于斜杠命令需要逐个执行，建议按优先级分组安装：

1. **第一优先级**（核心开发）：python-development, javascript-typescript, backend-development
2. **第二优先级**（质量保证）：code-review-ai, debugging-toolkit, security-scanning
3. **第三优先级**（工作流）：unit-testing, git-pr-workflows, full-stack-orchestration
4. **按需安装**：根据具体项目需求安装其他插件

每个插件只会加载其特定的代理和技能到上下文中，保持系统高效运行。