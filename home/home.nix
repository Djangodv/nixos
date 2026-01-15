{ config, lib, pkgs, ... }:
{

  imports = [

    ./programs

  ];

  home = {

    # This needs to actually be set to your username
    username = "user";
    homeDirectory = "/home/user";

    packages = with pkgs; [

    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.11";
  };
}
