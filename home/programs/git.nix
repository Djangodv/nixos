{ pkgs, ... }:
  {

    programs.git = {
      enable = true;
      settings = {
	      user.name = "Djangodv";
        user.email = "dd.manders@protonmail.com";
      };
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

  }

