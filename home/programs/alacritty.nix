{ pkgs, ... }:
{

  programs.alacritty = {
    enable = true;
    theme = "kanagawa_dragon";
    settings = {

      font.size = 15;
      font = {
        size = 15;
      };
    
      keyboard.bindings = [
        {
          key = "Backspace";
          mods = "Control";
          chars = "\\u0017"; # instead of \x17 or \u{17}
        }
      ];
    
    };

  };

}
