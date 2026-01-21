{ pkgs, ... }:
{

  programs.git = {
    enable = true;
    settings = {
      user.name = "Djangodv";
      user.email = "dd.manders@protonmail.com";
      init.defaultBranch = "main";
      # Automatically set upstream to avoid: "current branch main has no upstream branch"
      push.autoSetupRemote = true;
      safe.directory = "/etc/nixos";
    };
  };
}
