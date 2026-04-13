# AI Text Tools for PopClip

[中文](#中文) | [English](#english)

---

## English

A PopClip extension that integrates AI capabilities, providing text expand, shorten, polish, translate, and custom prompt actions. Supports both OpenAI-compatible and Claude APIs.

### Features

| Button | Action | Description |
|--------|--------|-------------|
| Expand | Text expansion | Enrich details while preserving the original meaning |
| Shorten | Text shortening | Keep core information, remove redundancy |
| Polish | Text polishing | Improve fluency, fix grammar and wording |
| Translate | Translation | Auto-detect: CN→EN, EN→CN, others→CN |
| Custom | Custom prompt | Process text with your own prompt |

### Installation

1. Download the latest [Release](../../releases) or clone this repository
2. Double-click the `.popclipext` folder — PopClip will install it automatically
3. Configure your API settings in PopClip's extension preferences

### Configuration

| Option | Description | Default |
|--------|-------------|---------|
| AI Provider | API provider | `openai` |
| API Base URL | API endpoint URL | `https://api.openai.com/v1` |
| API Key | Your API key | *(required)* |
| Model | Model name | `gpt-5-nano` |
| Output Mode | Output behavior | `replace` (replace selected text) |
| Custom Prompt | Custom action prompt | `请帮我处理以下文本` |
| Enable Expand | Show/hide Expand button | ✅ |
| Enable Shorten | Show/hide Shorten button | ✅ |
| Enable Polish | Show/hide Polish button | ✅ |
| Enable Translate | Show/hide Translate button | ✅ |
| Enable Custom | Show/hide Custom button | ✅ |

#### OpenAI-compatible API

Works with OpenAI, DeepSeek, Qwen, Groq, and any OpenAI-compatible service:

- Provider: `OpenAI Compatible`
- API Base URL: `https://api.openai.com/v1`
- Model: `gpt-5-nano`

#### Claude API

- Provider: `Claude (Anthropic)`
- API Base URL: `https://api.anthropic.com/v1`
- Model: `claude-haiku-4-6-20250612`

#### Third-party Proxies

Supports any OpenAI-compatible proxy — just change the API Base URL and API Key.

### Output Modes

- **replace** (default): AI result replaces the selected text directly
- **copy**: Result is copied to clipboard with a confirmation message

### Technical Details

- Shell Script + curl for API calls — no additional dependencies needed
- Auto-handles SSE streaming responses (fallback parser for non-compliant APIs)
- Python3 for safe JSON escaping to handle special characters
- Icons from [Lucide](https://lucide.dev/) icon library
- Bilingual UI (English / Simplified Chinese) — follows your system language

### Requirements

- macOS 12+
- PopClip 2024.5+
- Python 3 (system built-in)
- jq (optional, for JSON parsing)

---

## 中文

一个 PopClip 扩展，集成 AI 能力，提供文本扩写、缩写、润色、翻译和自定义提示词操作。支持 OpenAI 兼容 API 和 Claude API。

### 功能

| 按钮 | 功能 | 说明 |
|------|------|------|
| 扩写 | 文本扩写 | 保持原意，丰富细节和表达 |
| 缩写 | 文本缩写 | 保留核心信息，去除冗余 |
| 润色 | 文本润色 | 更流畅自然，修正语法和用词 |
| 翻译 | 中英互译 | 自动检测：中→英，英→中，其他→中 |
| 自定义 | 自定义提示词 | 使用自定义 prompt 处理文本 |

### 安装

1. 下载最新的 [Release](../../releases) 或克隆本仓库
2. 双击 `.popclipext` 文件夹，PopClip 会自动安装
3. 在 PopClip 设置中配置 API 信息

### 配置

| 选项 | 说明 | 默认值 |
|------|------|--------|
| AI 提供商 | API 提供商 | `openai` |
| API 地址 | API 接口地址 | `https://api.openai.com/v1` |
| API 密钥 | 你的 API Key | （必填） |
| 模型 | 模型名称 | `gpt-5-nano` |
| 输出方式 | 结果输出行为 | `replace`（替换选中文字） |
| 自定义提示词 | 自定义操作的提示词 | `请帮我处理以下文本` |
| 启用 扩写 | 显示/隐藏扩写按钮 | ✅ |
| 启用 缩写 | 显示/隐藏缩写按钮 | ✅ |
| 启用 润色 | 显示/隐藏润色按钮 | ✅ |
| 启用 翻译 | 显示/隐藏翻译按钮 | ✅ |
| 启用 自定义 | 显示/隐藏自定义按钮 | ✅ |

#### OpenAI 兼容 API

适用于 OpenAI、DeepSeek、通义千问、Groq 等：

- 提供商：`OpenAI 兼容`
- API 地址：`https://api.openai.com/v1`
- 模型：`gpt-5-nano`

#### Claude API

- 提供商：`Claude (Anthropic)`
- API 地址：`https://api.anthropic.com/v1`
- 模型：`claude-haiku-4-6-20250612`

#### 第三方代理/中转

支持各种 OpenAI 兼容的中转服务，只需修改 API 地址和 API 密钥即可。

### 输出模式

- **replace**（默认）：AI 处理结果直接替换选中的文字
- **copy**：结果复制到剪贴板，显示确认提示

### 技术细节

- 使用 Shell Script + curl 调用 API，无需额外依赖
- 自动兼容 SSE 流式响应（某些 API 忽略 `stream:false` 时自动回退解析）
- Python3 用于安全的 JSON 转义，防止特殊字符问题
- 图标来自 [Lucide](https://lucide.dev/) 图标库
- 双语界面（英文 / 简体中文）——跟随系统语言自动切换

### 系统要求

- macOS 12+
- PopClip 2024.5+
- Python 3（系统自带）
- jq（可选，用于 JSON 解析）

## License

MIT
