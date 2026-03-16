#!/bin/bash
# 启动智能体监控面板 Web 服务器

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 使用与 TUI/网关相同的 OpenClaw home，以便监控面板和追踪器看到相同的会话
export OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"

# 检查虚拟环境是否存在
if [ ! -d "venv" ]; then
    echo "创建虚拟环境..."
    python3 -m venv venv
fi

# 激活虚拟环境
source venv/bin/activate

# 安装依赖
echo "安装依赖..."
pip install -q -r "$(dirname "$SCRIPT_DIR")/requirements.txt"

# 启动监控面板 (使用端口 8080 以避免 macOS AirPlay 接收器冲突)
PORT=${PORT:-8080}
echo "正在启动智能体监控面板..."
echo "请在浏览器中打开 http://localhost:$PORT"
PORT=$PORT python3 dashboard.py
