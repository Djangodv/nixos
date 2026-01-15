{pkgs, ... }:
{

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop"; 
      iconTheme = "Papirus-Dark";
    };

    kwin = {
      nightLight = {
        enable = true;
        mode = "times";
        temperature.night = 3200;
        time.morning = "07:00";
        time.evening = "19:00";
        transitionTime = 15;
      };
    };
  };

}

