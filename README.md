# Homebrew tap for Workx

Install the Workx CLI with:

```sh
brew tap RonanXiao/homebrew-workx
brew install workx
```

This formula builds Workx from source on macOS using the repository's package
builder and installs the full CLI layout (`workx`, `workx-code-mode-host`,
resources, and ripgrep). The first install can take a while because it compiles
the Rust workspace and downloads pinned V8/rg/zsh artifacts.

```sh
# Latest main branch
brew install --HEAD workx
```
