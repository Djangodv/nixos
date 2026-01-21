{ pkgs, ... }:
{

  programs.alacritty = {
    enable = true;
    theme = "kanagawa_dragon";
    settings = {

      font = {
        size = 15;

        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold Italic";
        };

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
