{ pkgs,  ... }:
{
  imports = [

     # Paths to other modules

     ./vim.nix
     ./git.nix
     ./plasma.nix
     ./ssh.nix
     ./alacritty.nix
     ./bash.nix
     ./firefox.nix
     ./nvim.nix

  ];
}

