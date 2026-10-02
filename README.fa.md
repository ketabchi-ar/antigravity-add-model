<p align="center">
  <img src="assets/banner.svg" width="100%" alt="Antigravity Custom Model Enabler Banner">
</p>

<h1 align="center">راهنمای فارسی Antigravity Custom Model Enabler</h1>

<p align="center">
  <strong>اتصال مدل‌های دلخواه، ۹Router، Ollama، Claude، OpenAI و DeepSeek به برنامه دسکتاپ Google Antigravity</strong>
</p>

<p align="center">
  <a href="README.md">English Documentation</a> ·
  <a href="#نصب-سریع-یک‌کلیکه">نصب سریع</a> ·
  <a href="#اتصال-به-9router">اتصال به ۹Router</a> ·
  <a href="#کانفیگ-آماده-quick-start">کانفیگ آماده</a> ·
  <a href="#عیب‌یابی-و-نکات-مهم">عیب‌یابی</a>
</p>

---

## درباره این پروژه

این ابزار با مهندسی معکوس و پچ کلاینت Electron برنامه **Google Antigravity** و باینری Language Server، محدودیت اتصال به سرورهای داخلی گوگل (`v1internal`) را برطرف کرده و یک پراکسی دوطرفه قدرتمند درون برنامه تزریق می‌کند. با این کار می‌توانید به جای وابستگی صرف به سهمیه‌های گوگل، از هر ارائه‌دهنده سازگار با OpenAPI یا گیت‌وی‌های محلی استفاده کنید.

### امکانات ویژه این نسخه (Fork):
* 🚀 **پریست پیش‌فرض ۹Router:** اتصال در لحظه به `http://127.0.0.1:20128/v1` بدون نیاز به تنظیم دستی URL.
* ✍️ **راست‌چین‌سازی هوشمند (RTL) و فونت وزیرمتن:** نمایش کامپوننت‌ها، فیلدها و پیام‌های فارسی با فونت استاندارد.
* 📦 **کانفیگ آماده یک‌کلیکه (`quick-start-config.json`):** اضافه کردن سریع مدل‌های مطرح Claude 3.5 Sonnet، GPT-4o و DeepSeek V3 از طریق گزینه Import.
* 🔄 **نصب هوشمند و ایمن (`deploy.sh`):** بستن خودکار پروسه‌های باز Antigravity پیش از نصب و اجرای مجدد خودکار پس از پچ.
* 🤖 **همگام‌سازی خودکار (Auto-Sync):** دریافت خودکار آخرین تغییرات ریپازیتوری مرجع توسط GitHub Actions.

---

## پیش‌نیازها

* برنامه رسمی دسکتاپ **Google Antigravity** (نسخه Standalone Desktop روی macOS / Windows / Linux)
* **Node.js** نسخه ۲۲.۱۳ یا بالاتر
* **Git**

---

## نصب سریع یک‌کلیکه

### ۱. کلون و بیلد پروژه
```bash
git clone https://github.com/ketabchi-ar/antigravity-add-model.git
cd antigravity-add-model
npm ci --ignore-scripts
npm run build
```

### ۲. اعمال پچ روی برنامه

* **در مک (macOS):**
  ```bash
  bash deploy.sh
  ```
  *(اسکریپت خودکار آنتی‌گراویتی را می‌بندد، پچ را اعمال کرده و برنامه را باز می‌کند).*

* **در ویندوز (Windows PowerShell):**
  ```powershell
  .\deploy.ps1
  ```

---

## کانفیگ آماده (Quick-Start)

برای راحتی شما، یک فایل آماده به نام `quick-start-config.json` در مخزن قرار دارد:

1. وارد تنظیمات برنامه شوید: **Settings → Models & Usage**
2. در بخش **Custom Models**، روی دکمه **Import** کلیک کنید.
3. محتوای فایل `quick-start-config.json` را داخل کادر Paste کرده و تأیید کنید.
4. بلافاصله مدل‌های **Claude 3.5 Sonnet**، **GPT-4o**، **DeepSeek V3** و **Gemini 2.5 Flash** با اتصال مستقیم به ۹Router لود می‌شوند.

---

## اتصال به ۹Router (یا هر API دیگر)

اگر می‌خواهید دستی مدلی اضافه کنید:
1. در برنامه وارد **Settings → Models & Usage** شوید.
2. روی دکمه **Add model** کلیک کنید.
3. در لیست Providerها گزینه **9Router (Local AI Gateway)** یا ارائه‌دهنده مد نظرتان را انتخاب کنید.
4. شناسه مدل (Model ID) را بنویسید (مثلاً `claude-3-5-sonnet`).
5. روی **Test connection** و سپس **Save model** بزنید.
6. مدل به منوی دراپ‌داون چت‌های Antigravity اضافه خواهد شد.

---

## عیب‌یابی و نکات مهم

### ۱. پچ بعد از آپدیت گوگل پرید، چکار کنم؟
با هر بار آپدیت خودکار برنامه توسط گوگل، فایل باینری جدید جایگزین نسخه پچ‌شده می‌شود. کافیست یک‌بار دیگر دستور زیر را اجرا کنید:
```bash
bash deploy.sh
```

### ۲. چرا بخش Custom Models در منو دیده نمی‌شود؟
مطمئن شوید حتماً وارد تب **Models & Usage** در سایدبار تنظیمات شده‌اید و پروسه قدیمی Antigravity در حافظه رم باز نمانده باشد.

### ۳. بازگردانی به نسخه اصلی و بدون پچ (Rollback)
برای لغو پچ و بازگرداندن فایل اورجینال گوگل:
```bash
node scripts/deploy.mjs --restore
```

---

## لایسنس

این پروژه بر پایه‌ی لایسنس [Apache License 2.0](LICENSE) منتشر شده است.
مخزن اصلی توسعه: [vahapogut/antigravity-add-model](https://github.com/vahapogut/antigravity-add-model)
