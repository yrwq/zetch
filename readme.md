# Zetch

A successor to [yafetch](https://github.com/yrwq/yafetch) written in [Zig](https://ziglang.org/).

Zetch provides a:

* Lua library, to fetch informations about your computer
* An executable to run the Lua configuration

### Requirements

* `Lua 5.4`
* `Zig 0.8.0`

## Installation

Locally to `$HOME/.local/bin`

```zsh
zig build -Drelease-safe --prefix ~/.local
```

System wide to `/usr/bin`

```zsh
zig build -Drelease-safe --prefix /usr
```

### Nix

* Flake
    ```zsh
    nix develop
    ```

* Non-Flake

    ```zsh
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
    sudo nix-channel --update
    nix-shell non-flake.nix
    ```
