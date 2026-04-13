# AI Text Tools for PopClip

一个 PopClip 扩展，集成 AI 能力，提供文本扩写、缩写、润色、翻译和自定义提示词操作。支持 OpenAI 兼容 API 和 Claude API。

## 功能

| 按钮 | 功能 | 说明 |
|------|------|------|
| 扩写 | 文本扩写 | 保持原意，丰富细节和表达 |
| 缩写 | 文本缩写 | 保留核心信息，去除冗余 |
| 润色 | 文本润色 | 更流畅自然，修正语法和用词 |
| 翻译 | 中英互译 | 自动检测：中→英，英→中，其他→中 |
| 自定义 | 自定义提示词 | 使用自定义 prompt 处理文本 |

## 安装

1. 下载最新的 [Release](../../releases) 或克隆本仓库
2. 双击 `.popclipext` 文件夹，PopClip 会自动安装
3. 在 PopClip 设置中配置 API 信息

## 配置

在 PopClip 扩展设置中填写以下信息：

| 选项 | 说明 | 默认值 |
|------|------|--------|
| AI Provider | API 提供商 | `openai` |
| API Base URL | API 地址 | `https://api.openai.com/v1` |
| API Key | API 密钥 | （必填） |
| Model | 模型名称 | `gpt-4o-mini` |
| Output Mode | 输出方式 | `replace`（替换选中文字） |
| Custom Prompt | 自定义提示词 | `请帮我处理以下文本` |
| 启用 扩写 | 显示/隐藏扩写按钮 | ✅ |
| 启用 缩写 | 显示/隐藏缩写按钮 | ✅ |
| 启用 润色 | 显示/隐藏润色按钮 | ✅ |
| 启用 翻译 | 显示/隐藏翻译按钮 | ✅ |
| 启用 自定义 | 显示/隐藏自定义按钮 | ✅ |

### OpenAI 兼容 API 示例

适用于 OpenAI、DeepSeek、通义千问、Groq 等：

- Provider: `openai`
- API Base URL: `https://api.openai.com/v1`
- Model: `gpt-4o-mini`

### Claude API 示例

- Provider: `claude`
- API Base URL: `https://api.anthropic.com/v1`
- Model: `claude-sonnet-4-20250514`

### 第三方代理/中转

支持各种 OpenAI 兼容的中转服务，只需修改 API Base URL 和 API Key 即可。

## 输出模式

- **replace**（默认）：AI 处理结果直接替换选中的文字
- **copy**：结果复制到剪贴板，显示确认提示

## 技术细节

- 使用 Shell Script + curl 调用 API，无需额外依赖
- 自动兼容 SSE 流式响应（某些 API 忽略 `stream:false` 时自动回退解析）
- Python3 用于安全的 JSON 转义，防止特殊字符问题
- 图标来自 [Lucide](https://lucide.dev/) 图标库

## 系统要求

- macOS 12+
- PopClip 2024.5+
- Python 3（系统自带）
- jq（用于 JSON 解析，可选）

## License

MIT
