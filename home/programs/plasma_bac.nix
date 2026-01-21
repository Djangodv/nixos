{pkgs, ... }:
{

  programs.plasma = {
    enable = true;

    configFile = {
      kdeglobals.General.AccentColor = "40,48,58";
      kdeglobals.General.LastUsedCustomAccentColor = "40,48,58";
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop"; 
      iconTheme = "Tela-dark";
      wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
    };

    kscreenlocker = {
      appearance.wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
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

    panels = [

      # Windows-like panel at the bottom
      {

        location = "bottom";
        opacity = "opaque";
        # floating = false;
        widgets = [

          {
            name = "org.kde.plasma.kickoff";
          }
          {
            name = "org.kde.plasma.icontasks";
            config.General.launchers = [
              "applications:org.kde.dolphin.desktop"
            ];
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
              ];
              hidden = [
                "org.kde.plasma.brightness"
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }

        ];
      }
    
    ];

    input = {
    
    };

  };
}

