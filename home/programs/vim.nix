{ pkgs, ... }:
{

  programs.vim = {
    enable = true;
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
