{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;  
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
      "github-school.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_school";
      };
    };
  };

  # Systemd service to generate SSH keys in the $HOME directory
  systemd.user.services.clientKeys = {
    Unit = {
      Description = "Generate default SSH keys with `ssh-keygen`";
      # After = [ "home-manager-user.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "generate-ssh-keys" ''
        if [[ ! -f /home/user/.ssh/id_ed25519 ]]; then
          ssh-keygen -f /home/user/.ssh/id_ed25519 -t ed25519 -b 4096 -C "user@nixos-demo"
        fi

        if [[ ! -f /home/user/.ssh/id_ed25519_school ]]; then
          ssh-keygen -f /home/user/.ssh/id_ed25519_school -t ed25519 -b 4096 -C "user@nixos-demo"
        fi
      ''}";
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
