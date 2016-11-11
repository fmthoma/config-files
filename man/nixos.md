# NixOS and Nix

## Using a local `nixpkgs`

Symlink local `nixpkgs` to `/etc/nixos/nixpkgs`:

```bash
cd /etc/nixos && sudo ln -s /path/to/nixpkgs
```

To rebuild NixOS with custom `$NIX_PATH`:

```bash
NIX_PATH="/etc/nixos:nixos-config=/etc/nixos/configuration.nix" sudo -E nixos-rebuild switch
```

To install a package from custom `$NIX_PATH`:

```bash
nix-env -f "<nixpkgs>" -I nixpkgs=/etc/nixos/nixpkgs -A -i <package>
```
