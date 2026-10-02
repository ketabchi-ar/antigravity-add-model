<p align="center">
  <img src="assets/banner.svg" width="100%" alt="Antigravity Custom Model Enabler Banner">
</p>

<h1 align="center">Antigravity Custom Model Enabler</h1>

<p align="center">
  <strong>Connect 9Router, Claude, OpenAI, DeepSeek, and custom AI models to Google Antigravity Desktop with Persian &amp; RTL support.</strong>
</p>

<p align="center">
  <a href="README.md"><strong>🇮🇷 راهنمای فارسی (Persian Documentation)</strong></a> ·
  <a href="#quick-installation">Quick start</a> ·
  <a href="#how-installsh-works">How it works</a> ·
  <a href="#connecting-to-9router">9Router Setup</a> ·
  <a href="#rollback-and-uninstall">Rollback</a>
</p>

---

## What does `install.sh` do?

When you run the unified installer, it automatically handles:
1. **Pre-flight Checks:** Verifies Node.js (22.13+), Git, Antigravity Desktop app, and local 9Router status.
2. **Project Compilation:** Installs dependencies and compiles TypeScript source code cleanly.
3. **Safe Application Shutdown:** Closes running Antigravity instances to prevent macOS / Windows file-lock issues.
4. **App Patching:** Injects the protocol translator and model management interface into Antigravity.
5. **Auto-Relaunch:** Restarts Antigravity ready with custom model features.

---

## Quick Installation

Run this single command in your terminal:

```bash
git clone https://github.com/ketabchi-ar/antigravity-add-model.git
cd antigravity-add-model
bash install.sh
```

*(On Windows, execute `.\deploy.ps1` in PowerShell).*

---

## Connecting to 9Router

1. Open Antigravity, go to **Settings → Models & Usage**.
2. Under the new **Custom Models** section, click **Add model**.
3. Select **9Router (Local AI Gateway)** from the Provider list:
   * The endpoint `http://127.0.0.1:20128/v1/chat/completions` is automatically populated.
4. **API Key:** Open `http://127.0.0.1:20128/dashboard/endpoint` in your browser, copy your key, and paste it into the **API Key** field.
5. Enter your **Model ID** (e.g. `claude-3-5-sonnet`, `gpt-4o`, `deepseek-chat`).
6. Click **Test connection** (green checkmark confirms ready status), then click **Save model**.

<p align="center">
  <img src="assets/add_custom_model_modal.png" width="420" alt="Add Model Modal">
  <img src="assets/custom_models_dashboard.png" width="850" alt="Custom Models Dashboard">
</p>

Now choose your custom model from the chat dropdown and enjoy unlimited coding without vendor lock-in!

---

## Rollback and Uninstall

To restore the clean official Google binary and remove the patch:

```bash
cd antigravity-add-model
node scripts/deploy.mjs --restore
```

Optionally remove saved custom models:
* macOS / Linux: `rm -f ~/.gemini/antigravity/custom_models.json`
* Windows: `Remove-Item "$env:USERPROFILE\.gemini\antigravity\custom_models.json" -Force`

---

## License

Apache License 2.0. Upstream development: [vahapogut/antigravity-add-model](https://github.com/vahapogut/antigravity-add-model).
