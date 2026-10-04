import * as http from 'node:http';
import * as https from 'node:https';
import * as tls from 'node:tls';
import * as net from 'node:net';

let cachedProxyUrl: string | null | undefined = undefined;
let cachedAgent: https.Agent | null | undefined = undefined;

export function checkPort(port: number, host = '127.0.0.1', timeout = 250): Promise<boolean> {
  return new Promise((resolve) => {
    const socket = new net.Socket();
    let settled = false;
    const finish = (open: boolean) => {
      if (settled) return;
      settled = true;
      socket.destroy();
      resolve(open);
    };
    socket.setTimeout(timeout);
    socket.on('connect', () => finish(true));
    socket.on('timeout', () => finish(false));
    socket.on('error', () => finish(false));
    socket.connect(port, host);
  });
}

export async function detectLocalProxy(): Promise<string | undefined> {
  if (cachedProxyUrl !== undefined) {
    return cachedProxyUrl || undefined;
  }
  const envProxy = process.env.HTTPS_PROXY || process.env.HTTP_PROXY || process.env.ALL_PROXY;
  if (envProxy) {
    cachedProxyUrl = envProxy;
    return envProxy;
  }

  // Common local proxy ports (Clash, v2ray, NekoBox)
  const commonPorts = [7890, 10809, 2081, 10808];
  for (const port of commonPorts) {
    if (await checkPort(port)) {
      const url = `http://127.0.0.1:${port}`;
      cachedProxyUrl = url;
      return url;
    }
  }

  cachedProxyUrl = null;
  return undefined;
}

export function createTunnelAgent(proxyUrl: string): https.Agent {
  const parsed = new URL(proxyUrl);
  const agent = new https.Agent();
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  (agent as any).createConnection = (
    options: https.RequestOptions,
    callback: (err: Error | null, socket?: tls.TLSSocket) => void,
  ) => {
    const req = http.request({
      host: parsed.hostname,
      port: Number(parsed.port) || 80,
      method: 'CONNECT',
      path: `${options.host}:${options.port || 443}`,
      headers: {
        Host: `${options.host}:${options.port || 443}`,
        ...(parsed.username
          ? {
              'Proxy-Authorization': `Basic ${Buffer.from(`${decodeURIComponent(parsed.username)}:${decodeURIComponent(parsed.password)}`).toString('base64')}`,
            }
          : {}),
      },
    });
    req.on('connect', (res, socket) => {
      if (res.statusCode === 200) {
        const tlsSocket = tls.connect(
          {
            socket,
            servername: options.servername || (typeof options.host === 'string' ? options.host : undefined),
          },
          () => callback(null, tlsSocket),
        );
        tlsSocket.on('error', (err) => callback(err));
      } else {
        socket.destroy();
        callback(new Error(`Proxy CONNECT rejected with HTTP ${res.statusCode}`));
      }
    });
    req.on('error', (err) => callback(err));
    req.end();
  };
  return agent;
}

export function getProxyAgent(customProxyUrl?: string): https.Agent | undefined {
  if (customProxyUrl) {
    return createTunnelAgent(customProxyUrl);
  }
  if (cachedAgent !== undefined) {
    return cachedAgent || undefined;
  }
  const envProxy = process.env.HTTPS_PROXY || process.env.HTTP_PROXY || process.env.ALL_PROXY || (cachedProxyUrl || undefined);
  if (envProxy) {
    cachedAgent = createTunnelAgent(envProxy);
    return cachedAgent;
  }
  return undefined;
}

export function getRelayUrl(): string | undefined {
  return process.env.GOOGLE_RELAY_URL?.replace(/\/$/, '') || undefined;
}

export function resetProxyCache(): void {
  cachedProxyUrl = undefined;
  cachedAgent = undefined;
}
