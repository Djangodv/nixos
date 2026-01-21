{ config, lib, pkgs, ... }:
{

  imports = [

    ./programs

  ];

  home = {

    # This needs to actually be set to your username
    username = "user";
    homeDirectory = "/home/user";

    activation.symlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sf /etc/nixos/theme/icons/ ~/.local/share/
      ln -sf /etc/nixos/theme/wallpapers/ ~/.local/share/
    '';

    packages = with pkgs; [
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.11";
  };
}
