# AI Text Tools for PopClip

[中文](#中文) | [English](#english)

---

## English

A PopClip extension that integrates AI capabilities, providing text expand, shorten, polish, translate, and custom prompt actions. Supports both OpenAI-compatible and Claude APIs.

### Features

| Button | Action | Description |
|--------|--------|-------------|
| ↔ Expand | Text expansion | Enrich details while preserving the original meaning |
| ↔ Shorten | Text shortening | Keep core information, remove redundancy |
| ✎ Polish | Text polishing | Improve fluency, fix grammar and wording |
| 文A Translate | Translation | Auto-detect: CN→EN, EN→CN, others→CN |
| ⚙ Custom | Custom prompt | Process text with your own prompt |

### Installation

1. Download `ai-text-tools.popclipextz` from the latest [Release](../../releases)
2. Double-click the `.popclipextz` file — PopClip will install it automatically
3. Configure your API settings in PopClip's extension preferences

### Configuration

| Option | Description | Default |
|--------|-------------|---------|
| AI Provider | API provider | `OpenAI Compatible` |
| API Base URL | API endpoint URL | `https://api.openai.com/v1` |
| API Key | Your API key | *(required)* |
| Model | Model name | `gpt-5-nano` |
| Output Mode | Output behavior | `Replace` |
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

| Mode | Description |
|------|-------------|
| **Replace** | AI result replaces the selected text directly |
| **Copy** | Result is copied to clipboard with a confirmation message |
| **Copy & Replace** | Result is copied to clipboard AND replaces the selected text |

### Custom Prompt Examples

The Custom action appends your selected text after the prompt. Here are some useful examples:

| Use Case | Custom Prompt |
|----------|---------------|
| Fix typos | `Fix all typos in the following text, output only the corrected text:` |
| Make formal | `Rewrite the following text in a formal tone, output only the result:` |
| Make casual | `Rewrite the following text in a casual, friendly tone, output only the result:` |
| Summarize | `Summarize the following text in one sentence, output only the summary:` |
| Explain like I'm 5 | `Explain the following text in simple terms a child could understand, output only the explanation:` |
| Continue writing | `Continue writing from where the following text ends, maintaining the same style, output only the continuation:` |
| Rewrite as bullet points | `Convert the following text into bullet points, output only the bullet points:` |
| Change perspective | `Rewrite the following text from a third-person perspective, output only the result:` |
| Make more persuasive | `Rewrite the following text to be more persuasive and compelling, output only the result:` |
| Extract key info | `Extract the key information and facts from the following text, output only the extracted content:` |
| 改错别字 | `修正以下文本中的所有错别字，只输出修正后的文本：` |
| 变正式 | `将以下文本改写为正式语气，只输出改写结果：` |
| 变口语化 | `将以下文本改写为口语化、轻松的语气，只输出改写结果：` |
| 一句话总结 | `用一句话总结以下文本，只输出总结：` |
| 续写 | `接着以下文本继续写，保持相同风格，只输出续写内容：` |
| 提取要点 | `从以下文本中提取关键信息和要点，只输出提取的内容：` |
| 改为列表 | `将以下文本转换为要点列表，只输出列表内容：` |
| 更有说服力 | `将以下文本改写得更有说服力，只输出改写结果：` |
| 小白解释 | `用通俗易懂的语言解释以下文本，只输出解释内容：` |

### Technical Details

- Shell Script + curl for API calls — no additional dependencies needed
- Auto-handles SSE streaming responses (fallback parser for non-compliant APIs)
- Python3 for safe JSON escaping to handle special characters
- Bilingual UI (English / Simplified Chinese) — follows your system language
- Language-aware translation direction (auto-detects CN/EN and translates accordingly)

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
| ↔ 扩写 | 文本扩写 | 保持原意，丰富细节和表达 |
| ↔ 缩写 | 文本缩写 | 保留核心信息，去除冗余 |
| ✎ 润色 | 文本润色 | 更流畅自然，修正语法和用词 |
| 文A 翻译 | 中英互译 | 自动检测：中→英，英→中，其他→中 |
| ⚙ 自定义 | 自定义提示词 | 使用自定义 prompt 处理文本 |

### 安装

1. 从最新的 [Release](../../releases) 下载 `ai-text-tools.popclipextz`
2. 双击 `.popclipextz` 文件，PopClip 会自动安装
3. 在 PopClip 设置中配置 API 信息

### 配置

| 选项 | 说明 | 默认值 |
|------|------|--------|
| AI 提供商 | API 提供商 | `OpenAI Compatible` |
| API 地址 | API 接口地址 | `https://api.openai.com/v1` |
| API 密钥 | 你的 API Key | （必填） |
| 模型 | 模型名称 | `gpt-5-nano` |
| 输出方式 | 结果输出行为 | `Replace` |
| 自定义提示词 | 自定义操作的提示词 | `请帮我处理以下文本` |
| 启用 扩写 | 显示/隐藏扩写按钮 | ✅ |
| 启用 缩写 | 显示/隐藏缩写按钮 | ✅ |
| 启用 润色 | 显示/隐藏润色按钮 | ✅ |
| 启用 翻译 | 显示/隐藏翻译按钮 | ✅ |
| 启用 自定义 | 显示/隐藏自定义按钮 | ✅ |

#### OpenAI 兼容 API

适用于 OpenAI、DeepSeek、通义千问、Groq 等：

- 提供商：`OpenAI Compatible`
- API 地址：`https://api.openai.com/v1`
- 模型：`gpt-5-nano`

#### Claude API

- 提供商：`Claude (Anthropic)`
- API 地址：`https://api.anthropic.com/v1`
- 模型：`claude-haiku-4-6-20250612`

#### 第三方代理/中转

支持各种 OpenAI 兼容的中转服务，只需修改 API 地址和 API 密钥即可。

### 输出模式

| 模式 | 说明 |
|------|------|
| **Replace** / 替换 | AI 处理结果直接替换选中的文字 |
| **Copy** / 复制 | 结果复制到剪贴板，显示确认提示 |
| **Copy & Replace** / 复制并替换 | 结果复制到剪贴板，同时替换选中文字 |

### 自定义提示词示例

自定义操作会将选中文本附加在提示词后面。以下是一些常用示例：

| 用途 | 自定义提示词 |
|------|-------------|
| 改错别字 | `修正以下文本中的所有错别字，只输出修正后的文本：` |
| 变正式 | `将以下文本改写为正式语气，只输出改写结果：` |
| 变口语化 | `将以下文本改写为口语化、轻松的语气，只输出改写结果：` |
| 一句话总结 | `用一句话总结以下文本，只输出总结：` |
| 续写 | `接着以下文本继续写，保持相同风格，只输出续写内容：` |
| 提取要点 | `从以下文本中提取关键信息和要点，只输出提取的内容：` |
| 改为列表 | `将以下文本转换为要点列表，只输出列表内容：` |
| 更有说服力 | `将以下文本改写得更有说服力，只输出改写结果：` |
| 小白解释 | `用通俗易懂的语言解释以下文本，只输出解释内容：` |
| Fix typos | `Fix all typos in the following text, output only the corrected text:` |
| Make formal | `Rewrite the following text in a formal tone, output only the result:` |
| Make casual | `Rewrite the following text in a casual, friendly tone, output only the result:` |
| Summarize | `Summarize the following text in one sentence, output only the summary:` |
| Explain like I'm 5 | `Explain the following text in simple terms a child could understand, output only the explanation:` |
| Continue writing | `Continue writing from where the following text ends, maintaining the same style, output only the continuation:` |
| Rewrite as bullet points | `Convert the following text into bullet points, output only the bullet points:` |
| Make more persuasive | `Rewrite the following text to be more persuasive and compelling, output only the result:` |
| Extract key info | `Extract the key information and facts from the following text, output only the extracted content:` |

### 技术细节

- 使用 Shell Script + curl 调用 API，无需额外依赖
- 自动兼容 SSE 流式响应（某些 API 忽略 `stream:false` 时自动回退解析）
- Python3 用于安全的 JSON 转义，防止特殊字符问题
- 双语界面（英文 / 简体中文）——跟随系统语言自动切换
- 翻译自动检测语言方向（中→英 / 英→中）

### 系统要求

- macOS 12+
- PopClip 2024.5+
- Python 3（系统自带）
- jq（可选，用于 JSON 解析）

## License

MIT
