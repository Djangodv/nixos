{ pkgs, ... }:
{

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;
    # plugins = with pkgs.vimPlugins; [ ];
    settings = { 
      ignorecase = true; 
      tabstop = 2;
      shiftwidth = 2;
      number = true;
    };
    extraConfig = ''
      set mouse=a
    '';
  };
}
