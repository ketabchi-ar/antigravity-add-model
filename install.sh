#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=====================================================${NC}"
echo -e "${CYAN}   🚀 بررسی خودکار پیش‌نیازها و نصب پچ Antigravity   ${NC}"
echo -e "${CYAN}=====================================================${NC}"

OS="$(uname -s)"
FAILURES=0

# 1. Check Node.js
echo -ne "🔍 بررسی نصب بودن Node.js... "
if command -v node >/dev/null 2>&1; then
  NODE_VER=$(node -v | sed 's/v//')
  NODE_MAJOR=$(echo "$NODE_VER" | cut -d'.' -f1)
  NODE_MINOR=$(echo "$NODE_VER" | cut -d'.' -f2)
  if [ "$NODE_MAJOR" -gt 22 ] || { [ "$NODE_MAJOR" -eq 22 ] && [ "$NODE_MINOR" -ge 13 ]; }; then
    echo -e "${GREEN}✓ تأیید شد (نسخه v$NODE_VER)${NC}"
  else
    echo -e "${YELLOW}⚠ نسخه فعلی v$NODE_VER است. پیشنهاد می‌شود Node.js 22.13+ نصب کنید.${NC}"
  fi
else
  echo -e "${RED}✗ یافت نشد!${NC}"
  echo -e "   لطفاً Node.js نسخه 22.13 یا بالاتر را نصب کنید (https://nodejs.org)."
  FAILURES=$((FAILURES + 1))
fi

# 2. Check npm
echo -ne "🔍 بررسی ابزار npm... "
if command -v npm >/dev/null 2>&1; then
  NPM_VER=$(npm -v)
  echo -e "${GREEN}✓ تأیید شد (v$NPM_VER)${NC}"
else
  echo -e "${RED}✗ یافت نشد!${NC}"
  FAILURES=$((FAILURES + 1))
fi

# 3. Check Git
echo -ne "🔍 بررسی ابزار Git... "
if command -v git >/dev/null 2>&1; then
  echo -e "${GREEN}✓ تأیید شد${NC}"
else
  echo -e "${RED}✗ یافت نشد!${NC}"
  FAILURES=$((FAILURES + 1))
fi

# 4. Check Antigravity Installation
echo -ne "🔍 بررسی نصب بودن برنامه رسمی Antigravity... "
APP_FOUND=false
if [ "$OS" = "Darwin" ]; then
  if [ -d "/Applications/Antigravity.app" ] || [ -d "$HOME/Applications/Antigravity.app" ]; then
    APP_FOUND=true
  fi
elif [ "$OS" = "Linux" ]; then
  if [ -d "$HOME/.local/share/Programs/antigravity" ] || [ -d "/opt/antigravity" ] || [ -d "/usr/lib/antigravity" ]; then
    APP_FOUND=true
  fi
else
  # Fallback check
  APP_FOUND=true
fi

if [ "$APP_FOUND" = true ]; then
  echo -e "${GREEN}✓ برنامه Antigravity پیدا شد${NC}"
else
  echo -e "${RED}✗ برنامه Antigravity یافت نشد!${NC}"
  echo -e "   مطمئن شوید برنامه دسکتاپ Antigravity در پوشه Applications نصب شده است."
  FAILURES=$((FAILURES + 1))
fi

# 5. Check 9Router (Optional helper)
echo -ne "🔍 بررسی وضعیت 9Router (اختیاری)... "
if curl -s --max-time 1 http://127.0.0.1:20128/ >/dev/null 2>&1 || curl -s --max-time 1 http://127.0.0.1:20128/v1/models >/dev/null 2>&1; then
  echo -e "${GREEN}✓ در حال اجرا روی پورت 20128${NC}"
else
  echo -e "${YELLOW}○ خاموش یا در دسترس نیست (بعداً در صورت نیاز روشن کنید)${NC}"
fi

# 6. Check Proxy / VPN for Google OAuth & Cloud Code
echo -e "${CYAN}💡 راهنمایی: برای عبور بدون مشکل از تحریم گوگل، فیلترشکن خود (Clash, v2ray, NekoBox و ...) را روشن نگه دارید.${NC}"
echo -ne "🔍 بررسی خودکار درگاه‌های پروکسی سیستم... "
DETECTED_PROXY=$(node -e '
const net = require("net");
const ports = [7890, 10809, 2081, 10808];
(async () => {
  for (const p of ports) {
    const ok = await new Promise(r => {
      const s = new net.Socket();
      s.setTimeout(250);
      s.on("connect", () => { s.destroy(); r(true); });
      s.on("timeout", () => { s.destroy(); r(false); });
      s.on("error", () => { s.destroy(); r(false); });
      s.connect(p, "127.0.0.1");
    });
    if (ok) { console.log("http://127.0.0.1:" + p); process.exit(0); }
  }
})();
' 2>/dev/null || true)

if [ -n "$DETECTED_PROXY" ]; then
  PROXY_PORT=$(echo "$DETECTED_PROXY" | cut -d':' -f3)
  echo -e "${GREEN}✓ فیلترشکن روی پورت $PROXY_PORT شناسایی شد (دور زدن تحریم فعال است)${NC}"
  export HTTPS_PROXY="$DETECTED_PROXY"
  export HTTP_PROXY="$DETECTED_PROXY"
elif [ -n "${HTTPS_PROXY:-}" ] || [ -n "${ALL_PROXY:-}" ]; then
  echo -e "${GREEN}✓ پروکسی از متغیرهای محیطی سیستم تنظیم شده است${NC}"
else
  echo -e "${YELLOW}○ فیلترشکن محلی باز یافت نشد (در صورت نیاز به لاگین گوگل، VPN/TUN را روشن کنید)${NC}"
fi

# Summary check
if [ "$FAILURES" -gt 0 ]; then
  echo -e "\n${RED}❌ برخی پیش‌نیازهای ضروری آماده نیستند. لطفاً موارد قرمز را رفع کنید.${NC}"
  exit 1
fi

echo -e "\n${GREEN}✨ تمام پیش‌نیازهای ضروری آماده هستند!${NC}\n"

# Step: Build if not built
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ ! -d "node_modules" ]; then
  echo -e "${BLUE}📦 در حال نصب وابستگی‌های پروژه (npm ci)...${NC}"
  npm ci --ignore-scripts
fi

echo -e "${BLUE}🔨 در حال کامپایل پروژه (npm run build)...${NC}"
npm run build

echo -e "\n${BLUE}🚀 در حال اعمال پچ روی برنامه Antigravity...${NC}"
bash "$SCRIPT_DIR/deploy.sh" "$@"
