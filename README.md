<p align="center">
  <img src="assets/banner.svg" width="100%" alt="Antigravity Custom Model Enabler Banner">
</p>

<h1 align="center">راهنمای جامع فارسی Antigravity Custom Model Enabler</h1>

<p align="center">
  <strong>آموزش گام‌به‌گام اتصال ۹Router، Claude، OpenAI، DeepSeek و مدل‌های دلخواه به برنامه دسکتاپ Google Antigravity</strong>
</p>

<p align="center">
  <a href="README.en.md"><strong>🌐 English Documentation</strong></a> ·
  <a href="#مرحله-۱-نصب-خودکار-با-یک-دستور">نصب خودکار</a> ·
  <a href="#مرحله-۲-افزودن-مدل-از-طریق-۹router">افزودن مدل ۹Router</a> ·
  <a href="#مرحله-۳-تست-اتصال-و-ذخیره">تست اتصال</a> ·
  <a href="#مرحله-۴-استفاده-در-چت-antigravity">استفاده در چت</a> ·
  <a href="#نحوه-پاک-کردن-تغییرات-و-بازگشت-به-حالت-اولیه-rollback">حذف و بازگشت (Rollback)</a>
</p>

---

## اسکریپت نصب چه کاری انجام می‌دهد؟ (`install.sh`)

وقتی دستور نصب را اجرا می‌کنید، اسکریپت به صورت هوشمند این مراحل را طی می‌کند:
1. **بررسی پیش‌نیازها:** بررسی نسخه Node.js (حداقل 22.13)، Git، وضعیت نصب Antigravity و اجرای 9Router.
2. **بیلد پروژه:** دریافت و کامپایل ماژول‌های پچ درون مخزن.
3. **بستن ایمن Antigravity:** در صورتی که برنامه باز باشد، آن را می‌بندد تا فایل‌های حافظه رم قفل نمانند.
4. **پچ کردن کلاینت:** فایل‌های رابط کاربری و مترجم پروتکل `v1internal` را تزریق می‌کند.
5. **اجرای مجدد برنامه:** برنامه Antigravity را با قابلیت‌های جدید باز می‌کند.

---

## مرحله ۱: نصب خودکار با یک دستور

ترمینال را باز کرده و این دستور یک‌خطی را اجرا کنید:

```bash
git clone https://github.com/ketabchi-ar/antigravity-add-model.git
cd antigravity-add-model
bash install.sh
```

*(در ویندوز می‌توانید فایل `.\deploy.ps1` را در PowerShell اجرا کنید).*

---

## مرحله ۲: افزودن مدل از طریق ۹Router (بسیار ساده و سریع)

دیگر نیازی به کپی کردن فایل‌های پیچیده JSON نیست! مراحل زیر را در برنامه انجام دهید:

1. وارد تنظیمات برنامه شوید: **Settings → Models & Usage** (یا تب Models).
2. در بخش جدید **Custom Models**، روی دکمه **Add model** کلیک کنید.
3. در منوی کشویی **Provider**، گزینه **9Router (Local AI Gateway)** را انتخاب کنید:
   * آدرس سرور به صورت خودکار `http://127.0.0.1:20128/v1/chat/completions` تنظیم می‌شود.
4. **دریافت کلید (API Key):**
   * داشبورد ۹Router را در مرورگر باز کنید: **`http://127.0.0.1:20128/dashboard/endpoint`**
   * مقدار **API Key** را کپی کرده و در فیلد **API Key** برنامه Paste کنید.
5. در فیلد **Model ID**، نام مدلی که در ۹Router دارید را وارد کنید (مثلاً: `claude-3-5-sonnet` یا `gpt-4o` یا `deepseek-chat`).
6. در فیلد **Display Name**، یک نام دلخواه برای نمایش در منو بنویسید (مثلاً: `کلود ۳.۵ سونات`).

<p align="center">
  <img src="assets/add_custom_model_modal.png" width="420" alt="فرم افزودن مدل جدید">
  <img src="assets/add_custom_model_provider_dropdown.png" width="420" alt="منوی انتخاب ارائه‌دهنده">
</p>

---

## مرحله ۳: تست اتصال و لود خودکار مدل‌ها

1. روی دکمه **Test connection** کلیک کنید:
   * **تیک سبز (✅ Connection successful):** یعنی کلید شما و اتصال به ۹Router تأیید شده است.
2. روی دکمه **Save model** بزنید تا مدل ذخیره شود.
3. **دریافت خودکار مدل‌ها (Fetch Models):**
   * برای سرویس‌هایی نظیر OpenRouter یا پرووایدرهای آنلاین، می‌توانید دکمه **Fetch provider models** را بزنید تا کل لیست مدل‌های فعال اکانت شما را دریافت کرده و با یک تیک اضافه کند.
   * برای سرورهای محلی (مثل Ollama)، دکمه **Discover local** در بالای صفحه تمام مدل‌های موجود را خودکار شناسایی می‌کند.

<p align="center">
  <img src="assets/custom_models_dashboard.png" width="850" alt="داشبورد مدیریت مدل‌ها">
</p>

---

## مرحله ۴: استفاده در چت Antigravity

پس از ذخیره مدل:
1. وارد محیط چت اصلی برنامه شوید.
2. منوی انتخاب مدل در بالای صفحه چت را باز کنید.
3. در کنار مدل‌های گوگلی، دسته‌بندی جدید **Custom Models** و مدل تعریف‌شده خود را خواهید دید.
4. آن را انتخاب کرده و مستقیماً کدنویسی و گفت‌وگو را آغاز کنید!

<p align="center">
  <img src="assets/chat_model_dropdown.png" width="700" alt="منوی انتخاب مدل در صفحه چت Antigravity">
</p>

---

## نحوه پاک کردن تغییرات و بازگشت به حالت اولیه (Rollback)

این پچ هیچ تغییری را به صورت غیرقابل بازگشت انجام نمی‌دهد و یک بک‌آپ رسمی نگهداری می‌کند. برای بازگشت ۱۰۰٪ به حالت اورجینال گوگل:

### گام ۱: بازگرداندن فایل اصلی برنامه
در پوشه پروژه دستور زیر را در ترمینال بزنید:

```bash
cd antigravity-add-model
node scripts/deploy.mjs --restore
```
خروجی تأییدیه بازگشت فایل اورجینال را چاپ می‌کند:
```text
RESTORED: standalone ... to /Applications/Antigravity.app/Contents/Resources
```

### گام ۲: پاک کردن مدل‌های ذخیره‌شده (اختیاری)
اگر مایلید فایل تنظیمات مدل‌ها نیز از سیستم حذف شود:
* **در مک و لینوکس:**
  ```bash
  rm -f ~/.gemini/antigravity/custom_models.json
  ```
* **در ویندوز (PowerShell):**
  ```powershell
  Remove-Item "$env:USERPROFILE\.gemini\antigravity\custom_models.json" -Force
  ```

---

## رفع اشکالات متداول

### ۱. بعد از آپدیت گوگل مدل‌ها ناپدید شدند!
با هر بار آپدیت خودکار برنامه توسط گوگل، کافیست یک‌بار دیگر در پوشه پروژه دستور زیر را اجرا کنید:
```bash
bash install.sh
```

### ۲. چرا بخش Custom Models در منوی تنظیمات دیده نمی‌شود؟
* مطمئن شوید وارد تب **Models & Usage** شده‌اید.
* برنامه Antigravity را یک‌بار به طور کامل ببندید (Quit) و مجدد باز کنید.

---

## لایسنس

پروژه تحت لایسنس [Apache License 2.0](LICENSE) منتشر شده است.
مخزن مرجع: [vahapogut/antigravity-add-model](https://github.com/vahapogut/antigravity-add-model)
