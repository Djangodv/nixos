{ pkgs,  ... }:
let
    # echo "Hello, World!"
  test-example = pkgs.writeShellScriptBin "hello-world" ''
    touch /home/user/NewFile.txt
  '';
in
{
  imports = [
     # Paths to other modules

     # They can be relative paths
     # ./otherModule.nix

     ./vim.nix
     ./git.nix
     ./plasma.nix
     ./ssh.nix
     ./alacritty.nix
     ./bash.nix
     ./firefox.nix

     # Or absolute
     # /path/to/otherModule.nix

     # Or to a directory
     # ../modules/home/shells/nushell
  ];

  home = {
    packages = 
    [
      # test-example
    ];
  };
}

