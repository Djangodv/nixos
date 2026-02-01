{ config, lib, pkgs, ... }:
let
  PROJECT_ROOT = builtins.toString ./.;
in
{

  imports = [

    ./programs

  ];

  home = {

    # This needs to actually be set to your username
    username = "user";
    homeDirectory = "/home/user";

    # NOTE: Using the actual path isn't the greatest solution (maybe copy from /nix/store instead?)
    activation.symlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sf ~/Github/nixos/theme/icons/ ~/.local/share/
      ln -sf ~/Github/nixos/theme/wallpapers/ ~/.local/share/
      ln -sf ~/Github/nixos/bookmarks/places.sqlite ~/.mozilla/firefox/default/places.sqlite
    '';

    packages = with pkgs; [
      spotify
			gimp
      tldr
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.11";
  };

  # Fonts
  # xdg.configFile."mimeapps.list".force = true;

}
