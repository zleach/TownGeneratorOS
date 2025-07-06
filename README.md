# Medieval Fantasy City Generator

This is the source code of the [Medieval Fantasy City Generator](https://watabou.itch.io/medieval-fantasy-city-generator/) (also available [here](http://fantasycities.watabou.ru/?size=15&seed=682063530)). It
lacks some of the latest features, namely waterbodies, options UI and some smaller ones. Maybe I'll update it later.

You'll need [OpenFL](https://github.com/openfl/openfl) and [msignal](https://github.com/massiveinteractive/msignal)
to run this code, both available through `haxelib`.

## Local Setup

```bash
# 1. Install Haxe & required libs (Homebrew example)
brew install haxe
export HAXE_STD_PATH="/opt/homebrew/lib/haxe/std"  # for bash/zsh rc

# 2. Install project haxelibs
haxelib install lime 8.2.2 --always
haxelib install openfl 9.3.0 --always
haxelib install msignal 1.2.5 --always
haxelib set lime 8.2.2
haxelib set openfl 9.3.0

# 3. (Optional but recommended) Live-reload helper
yarn global add haxe-watchify  # or: npm install -g haxe-watchify
```

## Quick Start

- **One-off build + run**

  ```bash
  ./start.sh          # compiles for HTML5 canvas and opens a dev-server
  ```

- **Hot-reload while editing**
  ```bash
  ./watch.sh          # recompiles on file-save and refreshes browser
  ```
  `watch.sh` prefers `haxe-watchify` if found; otherwise it falls back to `fswatch` + `livereloadx`.  
  Use `./watch.sh --once` to run a single build (same as `start.sh`).

When the script finishes building it prints a local URL (e.g. `http://127.0.0.1:3000`). Open that in your browser – the page will auto-refresh every time you save a Haxe file.

## Repo Helpers

- `start.sh` – single build + dev-server (OpenFL `test html5`)
- `watch.sh` – incremental rebuild + LiveReload

Both scripts set `HAXE_STD_PATH` automatically for Homebrew installs and accept any extra flags you want to pass to `openfl`/`lime`.

---

Enjoy tinkering with the Medieval Fantasy City Generator!
