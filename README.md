<p align="center">
  <img src="assets/banner.svg" width="100%" alt="Antigravity Custom Model Enabler Banner">
</p>

<h1 align="center">راهنمای جامع فارسی Antigravity Custom Model Enabler</h1>

<p align="center">
  <strong>آموزش گام‌به‌گام اتصال ۹Router، Claude، OpenAI، DeepSeek و مدل‌های لوکال به برنامه رسمی دسکتاپ Google Antigravity</strong>
</p>

<p align="center">
  <a href="README.en.md"><strong>🌐 English Documentation</strong></a> ·
  <a href="#مرحله-۱-نصب-پچ-روی-سیستم">مراحل نصب</a> ·
  <a href="#مرحله-۲-اقدامات-پس-از-باز-شدن-برنامه">پس از باز شدن برنامه</a> ·
  <a href="#مرحله-۳-تست-ارتباط-و-لود-خودکار-مدل‌ها">تست ارتباط و لود مدل‌ها</a> ·
  <a href="#مرحله-۴-استفاده-از-مدل-در-محیط-چت">استفاده در چت</a> ·
  <a href="#نحوه-پاک-کردن-تغییرات-و-بازگشت-به-حالت-اولیه-rollback">حذف و بازگشت (Rollback)</a>
</p>

---

## فهرست راهنما
1. [پیش‌نیازها](#پیش‌نیازها)
2. [مرحله ۱: نصب پچ روی سیستم (مک و ویندوز)](#مرحله-۱-نصب-پچ-روی-سیستم)
3. [مرحله ۲: اقدامات پس از باز شدن برنامه (کجا بریم و چی کپی کنیم؟)](#مرحله-۲-اقدامات-پس-از-باز-شدن-برنامه)
   * [روش الف: ایمپورت سریع با فایل کانفیگ آماده (پیشنهادی)](#روش-الف-ایمپورت-سریع-با-کانفیگ-آماده-quick-start)
   * [روش ب: افزودن دستی مدل با پریست ۹Router](#روش-ب-افزودن-دستی-مدل)
4. [مرحله ۳: تست ارتباط و لود خودکار مدل‌ها](#مرحله-۳-تست-ارتباط-و-لود-خودکار-مدل‌ها)
5. [مرحله ۴: استفاده از مدل در محیط چت](#مرحله-۴-استفاده-از-مدل-در-محیط-چت)
6. [نحوه پاک کردن تغییرات و بازگشت به حالت اولیه (Rollback / Uninstall)](#نحوه-پاک-کردن-تغییرات-و-بازگشت-به-حالت-اولیه-rollback)
7. [رفع اشکالات متداول (FAQ)](#رفع-اشکالات-متداول)

---

## پیش‌نیازها

* نسخه مستقل دسکتاپ **Google Antigravity** نصب‌شده روی مک، لینوکس یا ویندوز.
* **Node.js** نسخه ۲۲.۱۳ یا بالاتر (برای بررسی در ترمینال بزنید: `node -v`).
* **Git** نصب شده روی سیستم.
* اگر قصد استفاده از ۹Router دارید، مطمئن شوید ۹Router در حال اجراست (معمولاً روی `http://127.0.0.1:20128`).

---

## مرحله ۱: نصب پچ روی سیستم

### قدم اول: دریافت پروژه و بیلد وابستگی‌ها
ترمینال را باز کرده و دستورات زیر را خط‌به‌خط اجرا کنید:

```bash
git clone https://github.com/ketabchi-ar/antigravity-add-model.git
cd antigravity-add-model
npm ci --ignore-scripts
npm run build
```

### قدم دوم: اعمال پچ روی برنامه Antigravity

* **روی سیستم‌عامل مک (macOS):**
  ```bash
  bash deploy.sh
  ```
  *(این اسکریپت هوشمند ابتدا بررسی می‌کند اگر برنامه Antigravity باز است، آن را مسالمت‌آمیز می‌بندد، پچ را اعمال کرده و مجدداً برنامه را باز می‌کند).*

* **روی سیستم‌عامل ویندوز (PowerShell):**
  ```powershell
  .\deploy.ps1
  ```

---

## مرحله ۲: اقدامات پس از باز شدن برنامه

پس از اجرای اسکریپت، برنامه Antigravity باز می‌شود. مراحل زیر را دنبال کنید:

1. روی آیکون چرخ‌دنده یا منوی **Settings** کلیک کنید.
2. از سایدبار سمت چپ وارد تب **Models & Usage** (یا Models) شوید.
3. صفحه را کمی به پایین اسکرول کنید؛ بخش جدیدی تحت عنوان **Custom Models** را مشاهده خواهید کرد.

<p align="center">
  <img src="assets/custom_models_dashboard.png" width="850" alt="پنل مدیریت مدل‌های کاستوم">
</p>

برای اضافه کردن مدل‌ها دو راه دارید:

### روش الف: ایمپورت سریع با کانفیگ آماده (Quick-Start)
ساده‌ترین روش استفاده از فایل کانفیگ آماده موجود در همین مخزن است:

1. در بخش **Custom Models**، روی دکمه **Import** کلیک کنید.
2. محتوای فایل `quick-start-config.json` موجود در پوشه پروژه را باز کرده و متن JSON آن را کپی کنید:

```json
{
  "version": 1,
  "models": [
    {
      "name": "models/9router-claude-3-5-sonnet",
      "displayName": "Claude 3.5 Sonnet (via 9Router)",
      "description": "Anthropic Claude 3.5 Sonnet routed via local 9Router gateway",
      "provider": "9router",
      "apiFormat": "openai",
      "apiUrl": "http://127.0.0.1:20128/v1/chat/completions",
      "externalModelName": "claude-3-5-sonnet",
      "enabled": true,
      "contextWindow": 200000,
      "maxOutputTokens": 8192,
      "timeout": 180000,
      "supportsVision": true
    },
    {
      "name": "models/9router-gpt-4o",
      "displayName": "GPT-4o (via 9Router)",
      "description": "OpenAI GPT-4o routed via local 9Router gateway",
      "provider": "9router",
      "apiFormat": "openai",
      "apiUrl": "http://127.0.0.1:20128/v1/chat/completions",
      "externalModelName": "gpt-4o",
      "enabled": true,
      "contextWindow": 128000,
      "maxOutputTokens": 4096,
      "timeout": 180000,
      "supportsVision": true
    },
    {
      "name": "models/9router-deepseek-v3",
      "displayName": "DeepSeek V3 (via 9Router)",
      "description": "DeepSeek V3 reasoning & coding routed via local 9Router gateway",
      "provider": "9router",
      "apiFormat": "openai",
      "apiUrl": "http://127.0.0.1:20128/v1/chat/completions",
      "externalModelName": "deepseek-chat",
      "enabled": true,
      "contextWindow": 64000,
      "maxOutputTokens": 8192,
      "timeout": 180000
    },
    {
      "name": "models/9router-gemini-flash",
      "displayName": "Gemini 2.5 Flash (via 9Router)",
      "description": "Fast multi-modal Gemini routed via local 9Router gateway",
      "provider": "9router",
      "apiFormat": "openai",
      "apiUrl": "http://127.0.0.1:20128/v1/chat/completions",
      "externalModelName": "gemini-2.5-flash",
      "enabled": true,
      "contextWindow": 1000000,
      "maxOutputTokens": 8192,
      "timeout": 120000,
      "supportsVision": true
    }
  ]
}
```

3. متن بالا را در کادر پنجره **Import** قرار داده (Paste کنید) و دکمه ذخیره را بزنید. مدل‌ها درجا به لیست اضافه می‌شوند!

---

### روش ب: افزودن دستی مدل
اگر می‌خواهید مدلی را اختصاصی تنظیم کنید:

1. روی دکمه **Add model** کلیک کنید.
2. در پنجره باز شده، از منوی **Provider** گزینه **9Router (Local AI Gateway)** یا سرویس دلخواهتان را انتخاب کنید.
   *(با انتخاب ۹Router، آدرس `http://127.0.0.1:20128/v1/chat/completions` خودکار پر می‌شود و نیازی به وارد کردن API Key نیست).*
3. در فیلد **Model ID**، نام مدل مورد نظر در ۹Router را وارد کنید (مثلاً `claude-3-5-sonnet` یا `gpt-4o`).
4. نام نمایشی دلخواهتان را در فیلد **Display Name** بنویسید (مثلاً `کلود ۳.۵ سونات`).

<p align="center">
  <img src="assets/add_custom_model_modal.png" width="420" alt="فرم افزودن مدل جدید">
  <img src="assets/add_custom_model_provider_dropdown.png" width="420" alt="منوی انتخاب ارائه‌دهنده">
</p>

---

## مرحله ۳: تست ارتباط و لود خودکار مدل‌ها

### ۱. تست برقراری ارتباط (Test Connection):
* در همان پنجره افزودن مدل (یا جلوی هر مدل ذخیره شده در داشبورد)، روی دکمه **Test connection** کلیک کنید.
* برنامه یک درخواست سبک احراز هویت به اندپوینت می‌فرستد:
  * **تیک سبز (✅ Connection successful):** یعنی ارتباط برقرار است، پورت در دسترس است و احراز هویت تأیید شده است.
  * **ضربدر قرمز (❌ Error):** در صورت خطا، علت (مانند خاموش بودن ۹Router یا اشتباه بودن آدرس/توکن) با پیام واضح نمایش داده می‌شود.

### ۲. لود خودکار لیست مدل‌ها از سرویس‌دهنده:
* **در سرویس‌های آنلاین (مانند OpenRouter یا Groq):** پس از وارد کردن API Key، دکمه **Fetch provider models** را بزنید. برنامه مستقیماً لیست تمامی مدل‌های در دسترس اکانت شما را دریافت کرده و با یک کلیک می‌توانید مدل‌های دلخواهتان را تیک بزنید تا ذخیره شوند.
* **در مدل‌های محلی (Local):** اگر از Ollama یا LM Studio استفاده می‌کنید، کافیست روی دکمه **Discover local** کلیک کنید تا مدل‌های لودشده روی سیستم را اسکن و اضافه کند.

---

## مرحله ۴: استفاده از مدل در محیط چت

پس از ذخیره مدل‌ها:
1. به صفحه چت اصلی Antigravity برگردید.
2. منوی کشویی انتخاب مدل در بالای پنجره چت را باز کنید.
3. در کنار مدل‌های پیش‌فرض گوگل (Gemini)، اکنون دسته‌بندی جدید **Custom Models** را مشاهده می‌کنید که مدل‌های اضافه‌شده (مانند Claude 3.5 یا GPT-4o) در آن لیست شده‌اند.
4. مدل مورد نظرتان را انتخاب کرده و مستقیماً پیام بدهید! درخواست‌ها در پشت صحنه از طریق پراکسی محلی به ۹Router یا اندپوینت مقصد رله می‌شوند.

<p align="center">
  <img src="assets/chat_model_dropdown.png" width="700" alt="منوی انتخاب مدل در صفحه چت Antigravity">
</p>

---

## نحوه پاک کردن تغییرات و بازگشت به حالت اولیه (Rollback)

اگر به هر دلیلی خواستید پچ را کاملاً حذف کنید و برنامه Antigravity را به همان حالت اولیه و اورجینال کارخانه‌ای بازگردانید، نیازی به نصب مجدد برنامه نیست:

### گام ۱: بازگرداندن فایل اصلی برنامه (Clean Restore)
اسکریپت نصب در اولین اجرا، یک نسخه پشتیبان دقیق با هش تأییدشده از فایل `app.asar` برنامه در مسیر زیر ذخیره کرده است:
`/Applications/Antigravity.app/Contents/Resources/.antigravity-model-patch/backups/`

برای بازیابی خودکار آن، کافیست در پوشه پروژه دستور زیر را در ترمینال بزنید:

```bash
cd antigravity-add-model
node scripts/deploy.mjs --restore
```
خروجی تأییدیه بازگشت فایل اورجینال را چاپ می‌کند:
```text
RESTORED: standalone ... to /Applications/Antigravity.app/Contents/Resources
```

### گام ۲: پاک کردن مدل‌های ذخیره‌شده (اختیاری)
اگر می‌خواهید فایل تنظیمات مدل‌های کاستوم نیز از روی سیستم پاک شود:

* **در مک و لینوکس:**
  ```bash
  rm -f ~/.gemini/antigravity/custom_models.json
  ```
* **در ویندوز (PowerShell):**
  ```powershell
  Remove-Item "$env:USERPROFILE\.gemini\antigravity\custom_models.json" -Force
  ```

با انجام این کار، برنامه به وضعیت ۱۰۰٪ پیش‌فرض گوگل برمی‌گردد.

---

## رفع اشکالات متداول

### ۱. بعد از آپدیت رسمی Antigravity توسط گوگل، مدل‌ها ناپدید شدند!
گوگل در هر آپدیت، فایل کلاینت را بازنویسی می‌کند. هر زمان آپدیت آمد، فقط کافیست یک‌بار دیگر در پوشه پروژه دستور زیر را بزنید تا پچ مجدداً اعمال شود:
```bash
bash deploy.sh
```

### ۲. بخش Custom Models در منوی تنظیمات نمایش داده نمی‌شود!
* مطمئن شوید وارد تب **Models & Usage** شده‌اید.
* مطمئن شوید نسخه قبلی برنامه در پس‌زمینه مک باز نمانده باشد (یک‌بار Antigravity را کاملاً ببندید و دوباره باز کنید).

### ۳. تفاوت آدرس `/v1` و `/v1/chat/completions` چیست؟
هیچ تفاوتی ندارد. سیستم نرمال‌سازی این پروژه به صورت هوشمند هر دو را شناسایی کرده و به صورت خودکار به اندپوینت استاندارد چت ۹Router وصل می‌کند.

---

## لایسنس و اعتبار

این پروژه تحت مجوز [Apache License 2.0](LICENSE) منتشر شده است.
مخزن اصلی توسعه‌دهنده مرجع: [vahapogut/antigravity-add-model](https://github.com/vahapogut/antigravity-add-model)
