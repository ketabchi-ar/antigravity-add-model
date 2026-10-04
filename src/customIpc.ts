/** Addon-owned channels only; vendor desktop APIs are left intact. */
import { app, ipcMain, shell, BrowserWindow } from 'electron';
import * as path from 'node:path';
import * as cryptoStore from './cryptoStore';
import { createModelManager } from './modelManagement';
import { detectLocalProxy } from './proxy/proxyAgent';

async function openExternalOrAuthWindow(url: string): Promise<void> {
  if (!url.includes('accounts.google.com')) {
    await shell.openExternal(url);
    return;
  }
  try {
    const proxy = await detectLocalProxy();
    const authWin = new BrowserWindow({
      width: 520,
      height: 680,
      title: 'Google Sign In',
      autoHideMenuBar: true,
      webPreferences: {
        nodeIntegration: false,
        contextIsolation: true,
      },
    });
    if (proxy) {
      await authWin.webContents.session.setProxy({ proxyRules: proxy });
    }
    authWin.webContents.setUserAgent(
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
    );
    authWin.webContents.on('will-redirect', (_event, redirectUrl) => {
      if (redirectUrl.includes('/oauth2callback')) {
        setTimeout(() => {
          if (!authWin.isDestroyed()) authWin.close();
        }, 1200);
      }
    });
    await authWin.loadURL(url);
  } catch {
    await shell.openExternal(url);
  }
}

export function registerCustomModelHandlers(): void {
  const manager = createModelManager(
    path.join(app.getPath('home'), '.gemini', 'antigravity'),
    cryptoStore,
    openExternalOrAuthWindow,
  );
  const handle = (channel: string, action: (...args: any[]) => unknown) => {
    ipcMain.handle(channel, async (_event, ...args) => {
      try {
        return await action(...args);
      } catch (error) {
        if (channel === 'storage:get-custom-models' || channel === 'storage:export-custom-models') throw error;
        const status = (error as { status?: number }).status;
        return { success: false, error: (error as Error).message, ...(status ? { status } : {}) };
      }
    });
  };
  handle('storage:get-custom-models', () => manager.store.list());
  handle('storage:save-custom-model', manager.saveModel);
  handle('storage:delete-custom-model', (name) => {
    manager.store.delete(name);
    return { success: true };
  });
  handle('storage:test-model-connection', (model) => manager.testModel(model));
  handle('storage:get-provider-presets', manager.presets);
  handle('storage:discover-models', manager.discoverModels);
  handle('storage:discover-local', manager.discoverLocal);
  handle('storage:export-custom-models', () => manager.store.export());
  handle('storage:import-custom-models', (payload) => ({ success: true, count: manager.store.import(payload) }));
  handle('storage:get-gateway', manager.getGateway);
  handle('storage:save-gateway', manager.saveGateway);
  handle('storage:test-gateway', manager.testGateway);
  handle('storage:import-gateway-models', manager.importGatewayModels);
  handle('storage:open-gateway-dashboard', manager.openDashboard);
  handle('storage:google-login', manager.googleLogin);
  handle('storage:google-login-cancel', manager.googleLoginCancel);
  handle('storage:google-test-account', manager.googleTestAccount);
  handle('storage:google-pool-status', manager.googlePoolStatus);
  handle('storage:get-proxy-status', async () => ({ proxy: await detectLocalProxy() }));
}
