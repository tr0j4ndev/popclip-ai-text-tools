#!/bin/zsh
# AI Text Tools - PopClip Extension
# Unified request script for all AI actions

set -uo pipefail

# --- Detect system language ---
case "${LANG:-}" in
  zh_*) LANG="zh" ;;
  *)    LANG="en" ;;
esac

# --- Localized messages ---
t_no_key="❌ 请先在扩展设置中填写 API Key"
t_no_text="❌ 没有选中文字"
t_unknown="❌ 未知操作"
t_fail="❌ 请求失败"
t_no_result="❌ AI 未返回有效内容"
t_copied="✓ 已复制到剪贴板"
t_copied_replaced="✓ 已复制并替换"

if [[ "$LANG" == "en" ]]; then
  t_no_key="❌ Please enter your API Key in extension settings"
  t_no_text="❌ No text selected"
  t_unknown="❌ Unknown action"
  t_fail="❌ Request failed"
  t_no_result="❌ AI returned no content"
  t_copied="✓ Copied to clipboard"
t_copied_replaced="✓ Copied & replaced"
fi

# --- Read PopClip environment ---
ACTION="${POPCLIP_ACTION_IDENTIFIER:-}"
TEXT="${POPCLIP_TEXT:-}"
PROVIDER="${POPCLIP_OPTION_PROVIDER:-openai}"
API_BASE_URL="${POPCLIP_OPTION_APIBASEURL:-https://api.openai.com/v1}"
API_KEY="${POPCLIP_OPTION_APIKEY:-}"
MODEL="${POPCLIP_OPTION_MODEL:-gpt-5-nano}"
OUTPUT_MODE="${POPCLIP_OPTION_OUTPUTMODE:-replace}"
CUSTOM_PROMPT="${POPCLIP_OPTION_CUSTOMPROMPT:-请帮我处理以下文本}"

# --- Validate inputs ---
if [[ -z "$API_KEY" ]]; then
  echo "$t_no_key"
  exit 1
fi

if [[ -z "$TEXT" ]]; then
  echo "$t_no_text"
  exit 1
fi

# --- Select prompt based on action identifier ---
case "$ACTION" in
  expand)
    if [[ "$LANG" == "zh" ]]; then
      SYSTEM_PROMPT="你是一个文本扩写助手。将用户提供的文本扩写，保持原意不变，丰富细节和表达。只输出扩写结果，不要添加任何前缀、解释或说明。"
    else
      SYSTEM_PROMPT="You are a text expansion assistant. Expand the text while preserving the original meaning, enriching details and expression. Output only the expanded result with no prefix, explanation, or commentary."
    fi
    USER_PROMPT="${TEXT}"
    ;;
  shorten)
    if [[ "$LANG" == "zh" ]]; then
      SYSTEM_PROMPT="你是一个文本缩写助手。将用户提供的文本缩写，保留核心信息，去除冗余。只输出缩写结果，不要添加任何前缀、解释或说明。"
    else
      SYSTEM_PROMPT="You are a text shortening assistant. Shorten the text, keeping core information and removing redundancy. Output only the shortened result with no prefix, explanation, or commentary."
    fi
    USER_PROMPT="${TEXT}"
    ;;
  polish)
    if [[ "$LANG" == "zh" ]]; then
      SYSTEM_PROMPT="你是一个文本润色助手。润色用户提供的文本，使其更流畅自然，修正语法和用词问题。只输出润色结果，不要添加任何前缀、解释或说明。"
    else
      SYSTEM_PROMPT="You are a text polishing assistant. Polish the text to make it more fluent and natural, fixing grammar and wording issues. Output only the polished result with no prefix, explanation, or commentary."
    fi
    USER_PROMPT="${TEXT}"
    ;;
  translate)
    if [[ "$LANG" == "zh" ]]; then
      SYSTEM_PROMPT="你是一个翻译助手。翻译用户提供的文本：如为中文则译为英文，如为英文则译为中文，其他语言译为中文。只输出翻译结果，不要添加任何前缀、解释或说明。"
    else
      SYSTEM_PROMPT="You are a translation assistant. Translate the text: if Chinese, translate to English; if English, translate to Chinese; other languages translate to English. Output only the translation with no prefix, explanation, or commentary."
    fi
    USER_PROMPT="${TEXT}"
    ;;
  custom)
    SYSTEM_PROMPT=""
    NL=$(printf '\n\n')
    USER_PROMPT="${CUSTOM_PROMPT}${NL}${TEXT}"
    ;;
  *)
    echo "$t_unknown: ${ACTION}"
    exit 1
    ;;
esac

# --- Build JSON payload using Python (safe escaping) ---
build_payload_openai() {
  python3 -c '
import sys, json
system_prompt = sys.argv[1]
user_prompt = sys.argv[2]
messages = []
if system_prompt:
    messages.append({"role": "system", "content": system_prompt})
messages.append({"role": "user", "content": user_prompt})
payload = {
    "model": sys.argv[3],
    "messages": messages,
    "temperature": 0.7,
    "stream": False
}
print(json.dumps(payload, ensure_ascii=False))
' "$SYSTEM_PROMPT" "$USER_PROMPT" "$MODEL"
}

build_payload_claude() {
  python3 -c '
import sys, json
system_prompt = sys.argv[1]
user_prompt = sys.argv[2]
payload = {
    "model": sys.argv[3],
    "max_tokens": 4096,
    "stream": False,
    "messages": [{"role": "user", "content": user_prompt}]
}
if system_prompt:
    payload["system"] = system_prompt
print(json.dumps(payload, ensure_ascii=False))
' "$SYSTEM_PROMPT" "$USER_PROMPT" "$MODEL"
}

# --- Prepare curl write-out format ---
CURL_FORMAT=$(python3 -c "print('%' + '{' + 'http_code' + '}')")

# --- SSE parser (for APIs that ignore stream:false) ---
parse_sse_openai() {
  python3 -c '
import sys, json
result = []
for line in open(sys.argv[1]):
    line = line.strip()
    if line.startswith("data:") and line != "data: [DONE]":
        try:
            obj = json.loads(line[5:].strip())
            choices = obj.get("choices", [])
            if choices:
                delta = choices[0].get("delta", {})
                text = delta.get("content", "")
                if text:
                    result.append(text)
        except: pass
print("".join(result))
' "$1"
}

parse_sse_claude() {
  python3 -c '
import sys, json
result = []
for line in open(sys.argv[1]):
    line = line.strip()
    if line.startswith("data:") and line != "data: [DONE]":
        try:
            obj = json.loads(line[5:].strip())
            delta = obj.get("delta", {})
            text = delta.get("text", "")
            if text:
                result.append(text)
        except: pass
print("".join(result))
' "$1"
}

# --- Build and send API request ---
TMPFILE=$(mktemp)
HTTP_CODE=""
RESULT=""

if [[ "$PROVIDER" == "claude" ]]; then
  CLAUDE_URL="${API_BASE_URL%/}/messages"
  PAYLOAD=$(build_payload_claude)

  HTTP_CODE=$(curl -s -o "$TMPFILE" -w "$CURL_FORMAT" \
    --max-time 60 \
    -X POST "$CLAUDE_URL" \
    -H "Content-Type: application/json" \
    -H "x-api-key: ${API_KEY}" \
    -H "anthropic-version: 2023-06-01" \
    -d "$PAYLOAD" 2>&1) || true

  if [[ "$HTTP_CODE" != "200" ]]; then
    ERROR_MSG=$(jq -r '.error.message // "error"' "$TMPFILE" 2>/dev/null) || ERROR_MSG=""
    rm -f "$TMPFILE"
    echo "$t_fail (HTTP ${HTTP_CODE}): ${ERROR_MSG}"
    exit 1
  fi

  RESULT=$(jq -r '.content[0].text // empty' "$TMPFILE" 2>/dev/null) || true
  if [[ -z "$RESULT" ]]; then
    RESULT=$(parse_sse_claude "$TMPFILE") || true
  fi
  rm -f "$TMPFILE"

else
  OPENAI_URL="${API_BASE_URL%/}/chat/completions"
  PAYLOAD=$(build_payload_openai)

  HTTP_CODE=$(curl -s -o "$TMPFILE" -w "$CURL_FORMAT" \
    --max-time 60 \
    -X POST "$OPENAI_URL" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${API_KEY}" \
    -d "$PAYLOAD" 2>&1) || true

  if [[ "$HTTP_CODE" != "200" ]]; then
    ERROR_MSG=$(jq -r '.error.message // "error"' "$TMPFILE" 2>/dev/null) || ERROR_MSG=""
    rm -f "$TMPFILE"
    echo "$t_fail (HTTP ${HTTP_CODE}): ${ERROR_MSG}"
    exit 1
  fi

  RESULT=$(jq -r '.choices[0].message.content // empty' "$TMPFILE" 2>/dev/null) || true
  if [[ -z "$RESULT" ]]; then
    RESULT=$(parse_sse_openai "$TMPFILE") || true
  fi
  rm -f "$TMPFILE"
fi

# --- Handle result ---
if [[ -z "$RESULT" ]]; then
  echo "$t_no_result"
  exit 1
fi

# Trim whitespace
RESULT=$(echo "$RESULT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [[ "$OUTPUT_MODE" == "copy" ]]; then
  echo -n "$RESULT" | pbcopy
  echo "$t_copied"
elif [[ "$OUTPUT_MODE" == "copy-replace" ]]; then
  echo -n "$RESULT" | pbcopy
  echo -n "$RESULT"
else
  echo -n "$RESULT"
fi
