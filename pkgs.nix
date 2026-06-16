{ pkgs, ... }:
{ 
  # List packages installed system-wide.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     wget
     git
     tree
     alacritty
     unzip
     firefox-esr
   ];
}
