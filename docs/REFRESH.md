# Refresh / Install

These are the common commands to rebuild, install, and smoke-test the system after this refactor.

## Update inputs and rebuild (local)
```bash
# Update flake inputs
nix flake update

# Format Nix files
nix fmt .

# Build + switch to controlstackos configuration
sudo nixos-rebuild switch --flake .#controlstackos
```

## New machine install (manual partition)
1. Boot the NixOS ISO and connect to the network.
2. Clone your repo:
   ```bash
   git clone git@github.com:ManganoConsulting/nixos-nymeria.git
   cd nixos-nymeria
   ```
3. Generate hardware config and copy it into hosts/controlstackos:
   ```bash
   sudo nixos-generate-config --show-hardware-config > hosts/controlstackos/hardware-configuration.nix
   ```
4. Install:
   ```bash
   sudo nixos-install --flake .#controlstackos
   ```
5. Reboot.

## Declarative partition (bcachefs root with disko on Firefly)
```bash
# Review and edit hosts/controlstackos/disko.nix to match your disk(s) first
# (for the HP Firefly 16 G11 with a single 1TB NVMe, /dev/nvme0n1 is expected)
nix run github:nix-community/disko -- --mode disko ./hosts/controlstackos/disko.nix

# After disko finishes, generate hardware config for the Firefly:
sudo nixos-generate-config --show-hardware-config > hosts/controlstackos/hardware-configuration.nix

# Then install using the controlstackos host configuration (bcachefs root)
sudo nixos-install --flake .#controlstackos
```

## VM smoke test
Fast local smoke test using the dedicated VM config:
```bash
# build & run
nix build .#nixosConfigurations.vm.config.system.build.vm
./result/bin/run-nixos-vm

# or via Just
just vm
```

## Secrets (sops-nix)
- AGE private key should live only at: ~/.config/sops/age/keys.txt (do not commit)
- Example to create a secret file:
  ```bash
  sops -e --input-type yaml --output secrets/example.yaml /dev/stdin <<'YAML'
  password: change-me
  YAML
  git add secrets/example.yaml
  ```
- Reference in hosts/nymeria/config.nix (uncomment the example) and use `config.sops.secrets.<name>.path` in services.

## Useful flake commands
```bash
# Lint & build checks
nix flake check --print-build-logs

# Dev shell with tools (alejandra, statix, deadnix, nil, nom, pre-commit)
nix develop

# Format all Nix files via flake formatter
nix fmt .
```

## Pre-commit hooks
When entering the dev shell, pre-commit hooks are auto-installed. To run all hooks manually:
```bash
nix build .#checks.x86_64-linux.pre-commit
```
