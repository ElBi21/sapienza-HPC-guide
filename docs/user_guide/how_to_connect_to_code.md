You can open a [Visual Studio Code Tunnel](https://code.visualstudio.com/docs/remote/tunnels) to be able to connect to the job remotely from your machine.

## Pre-requisites

- Install [Visual Studio Code](https://code.visualstudio.com/download) on your machine
- Sign up for a [GitHub](https://github.com/) or [Microsoft](https://account.microsoft.com/account/Account) account

## Launch a Tunnel

To launch a Visual Studio Code Tunnel, you can simply use the `srun` command:

```bash
srun [requirements] --pty code tunnel --no-sleep
```

Then, follow the on-screen instructions.

At some point, you will see a line like the following: `Open this link in your browser https://vscode.dev/tunnel/node...`.
Now, you have two ways of connecting:

=== "Through Visual Studio Code on your machine"

    Just click on the bottom left button, then on `Tunnel` or `Connect to Tunnel` and follow the login instructions.

=== "Through your browser"

    If you click on the link, you will open a webpage resembling the Visual Studio Code IDE. You can then use that webpage in place of the app.

??? note "Output of the command to launch a Tunnel"
    
    ```bash
    *
    * Visual Studio Code Server
    *
    * By using the software, you agree to
    * the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and
    * the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).
    *
    ✔ How would you like to log in to Visual Studio Code? · GitHub Account
    To grant access to the server, please log into https://github.com/login/device and use code 1234-5678
    ✔ What would you like to call this machine? · node...
    [2025-03-22 17:11:19] info Creating tunnel with the name: node...

    Open this link in your browser https://vscode.dev/tunnel/node...

    [2025-03-22 17:11:47] info [tunnels::connections::relay_tunnel_host] Opened new client on channel 2
    [2025-03-22 17:11:47] info [russh::server] wrote id
    [2025-03-22 17:11:47] info [russh::server] read other id
    [2025-03-22 17:11:47] info [russh::server] session is running
    [2025-03-22 17:11:49] info [rpc.0] Checking /home/guest/.vscode/cli/servers/Stable-ddc367ed5c8936efe395cffeec279b04ffd7db78/log.txt and /home/guest/.vscode/cli/servers/Stable-ddc367ed5c8936efe395cffeec279b04ffd7db78/pid.txt for a running server...
    [2025-03-22 17:11:49] info [rpc.0] Downloading Visual Studio Code server -> /tmp/.tmpchN687/vscode-server-linux-x64.tar.gz
    [2025-03-22 17:12:01] info [rpc.0] Starting server...
    [2025-03-22 17:12:01] info [rpc.0] Server started
    ```