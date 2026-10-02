<p align="center">
  <img src="assets/banner.svg" width="100%" alt="Antigravity Custom Model Enabler Banner">
</p>

<h1 align="center">Antigravity Custom Model Enabler</h1>

<p align="center">
  <strong>Connect 9Router, Claude, OpenAI, DeepSeek, and custom AI models to Google Antigravity Desktop with Persian &amp; RTL support.</strong>
</p>

<p align="center">
  <a href="README.md"><strong>🇮🇷 راهنمای فارسی (Persian Documentation)</strong></a> ·
  <a href="#quick-installation-all-os">Quick start (All OS)</a> ·
  <a href="#connecting-to-9router">9Router Setup</a> ·
  <a href="#fetch-models-automatically">Fetch Models</a> ·
  <a href="#rollback-and-uninstall">Rollback</a>
</p>

---

## What does `install.sh` do?

When you run the installer, it automatically handles:
1. **Pre-flight Checks:** Verifies Node.js (22.13+), Git, Antigravity Desktop app, and local 9Router status.
2. **Project Compilation:** Installs dependencies and compiles TypeScript source code cleanly.
3. **Safe Application Shutdown:** Closes running Antigravity instances to prevent macOS / Windows file-lock issues.
4. **App Patching:** Injects the protocol translator and model management interface into Antigravity.
5. **Auto-Relaunch:** Restarts Antigravity ready with custom model features.

---

## Quick Installation (All OS)

Clone the repository:
```bash
git clone https://github.com/ketabchi-ar/antigravity-add-model.git
cd antigravity-add-model
```

### macOS & Linux
```bash
bash install.sh
```

### Windows (PowerShell)
```powershell
.\deploy.ps1
```

---

## Connecting to 9Router

1. Open Antigravity, go to **Settings → Models & Usage**.
2. Under the new **Custom Models** section, click **Add model**.
3. Select **9Router (Local AI Gateway)** from the Provider list:
   * The endpoint `http://127.0.0.1:20128/v1/chat/completions` is automatically filled.
   * Format defaults to `OpenAI compatible`.
4. **Get API Key:** Open `http://127.0.0.1:20128/dashboard/endpoint` in your browser, copy your key, and paste it into the **API key** field.

<p align="center">
  <img src="assets/add_custom_model_modal.png" width="450" alt="Add Model Modal">
</p>

---

## Fetch Models Automatically (No Manual Typing)

1. Click **Test connection** (a green checkmark confirms authentication with 9Router).
2. Click **Fetch provider models**:
   * Antigravity directly queries 9Router and lists all configured active models (Claude 3.5 Sonnet, GPT-4o, DeepSeek, etc.).
3. Check the models you want to use.
4. Click **Add selected** at the bottom of the list.

<p align="center">
  <img src="assets/custom_models_dashboard.png" width="850" alt="Custom Models Dashboard">
</p>

Now switch back to chat, open the model picker dropdown, and select your custom models!

<p align="center">
  <img src="assets/chat_model_dropdown.png" width="700" alt="Chat model dropdown">
</p>

---

## Rollback and Uninstall

To restore the official Google runtime without re-installing:

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
