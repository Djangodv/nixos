{ pkgs,  ... }:
{
  imports = [

     # Paths to other modules
     ./git.nix
     ./plasma.nix
     ./ssh.nix
     ./alacritty.nix
     ./bash.nix
     ./firefox.nix
     ./nvim

  ];
}

