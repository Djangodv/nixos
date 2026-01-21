## NixOS configuration

### OS installation

Use `fdisk` to setup three different patitions on `/dev/sdX`:

1. EFI system partition
2. Swap partition
3. File system (Linux filesystem)

> Use `GPT` (eufi)

**Sources:**
1. https://linuxmind.dev/2025/09/02/how-to-install-the-operating-system-nixos/
2. https://www.youtube.com/watch?v=63sSGuclBn0&list=PLuRxZ95-8LY1mlotZMYGYib5sXJRw1RxW&index=1
3. https://nixos.wiki/wiki/NixOS_Installation_Guide#Legacy_bios_boot

### Setup

Run the following command inside `~/Github/nixos/`:

    sudo nixos-rebuild switch --flake .#nixos-demo
