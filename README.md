# OpenCode provider for Promptr

Build and install the provider with a C11 compiler, Make, `pkg-config`, and the
development files for `gio-2.0`, `json-glib-1.0`.

```sh
make
make install
```

The install target uses `${XDG_CONFIG_HOME:-$HOME/.config}/promptr/plugins/opencode`.
For a Promptr debug build, set `PLUGIN_DIR` to the corresponding directory under
`promptr-debug/plugins`.

Install the OpenCode CLI and sign in with `opencode auth login`.
Restart Promptr and open **Preferences → Providers**. Select **OpenCode**, run
**Test connection**, and click **Apply** if you changed the settings. Use
**Add provider** to create another profile.

Run `make test` for the adapter checks. The provider implements
[Promptr protocol 2.0](lib/promptr-protocol/PROTOCOL.md). The C helper is copied
from [Promptr](https://github.com/toxdes/promptr) at commit `11abf4d`.
