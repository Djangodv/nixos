{ ... }:
{
  imports = [
     # Paths to other modules

     # They can be relative paths
     # ./otherModule.nix

     ./vim.nix
     ./git.nix
     ./plasma.nix

     # Or absolute
     # /path/to/otherModule.nix

     # Or to a directory
     # ../modules/home/shells/nushell
  ];
}

