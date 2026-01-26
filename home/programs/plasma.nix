{pkgs, ... }:
{

  # NOTE: Scaling, opacity of bottom bar and tiling windows with Meta + T doesn't work

  programs.plasma = {
    enable = true;
    # overrideConfig = true;

    configFile = {
      # Accent color
      kdeglobals.General.AccentColor = "40,48,58";
      kdeglobals.General.LastUsedCustomAccentColor = "40,48,58";
      # Number of desktops
      kwinrc.Desktops.Number = 2;
      kwinrc.Desktops.Rows = 1;
      # Remove the 'pin' icon on the applications bar
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "M";
      kwinrc."org.kde.kdecoration2".ButtonsOnRight = "IAX";
      # Turn off: "show selected window" to fix annoying delay
      kwinrc.TabBox.HighlightWindows = false;
      # Changes font to a slighty bolder version
      kdeglobals.General.font = "Noto Sans,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      # Scale applications
      kwinrc.Xwayland.Scale = 1.2;
      # Enable natural scrolling
      kcminputrc."Libinput/1267/12356/ELAN1200:00 04F3:3044 Touchpad".NaturalScroll = true;

    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop"; 
      iconTheme = "Tela-dark";
      # wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
    };

    kscreenlocker = {
      # appearance.wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
    };

    shortcuts = {
      kwin."Grid View" = ["Meta+Tab" "Meta+G"];
      "services/firefox-esr.desktop"._launch = "Meta+F";
      "services/Alacritty.desktop"._launch = "Meta+Space";

      # Change focus
      kwin."Switch Window Down" = ["Meta+J" "Meta+Alt+Down"];
      kwin."Switch Window Left" = ["Meta+Alt+Left" "Meta+H"];
      kwin."Switch Window Right" = ["Meta+L" "Meta+Alt+Right"];
      kwin."Switch Window Up" = ["Meta+Alt+Up" "Meta+K"];

      # Switch window to desktop
      kwin."Window One Desktop to the Left" = ["Meta+Ctrl+Shift+Left" "Meta+Shift+Left"];
      kwin."Window One Desktop to the Right" = ["Meta+Ctrl+Shift+Right" "Meta+Shift+Right"];

      # Maximize window
      kwin."Window Maximize" = ["Meta+PgUp" "Meta+Shift+Up"];
      kwin."Window Minimize" = ["Meta+PgDown" "Meta+Shift+Down"];

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
      # effects.dimInactive.enable = true;
    };

    session.general.askForConfirmationOnLogout = false;

    panels = [

      # Windows-like panel at the bottom
      {
        location = "bottom";
        opacity = "opaque";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            name = "org.kde.plasma.icontasks";
            config.General.launchers = [
              "applications:Alacritty.desktop"
              "applications:firefox-esr.desktop"
              "applications:org.kde.dolphin.desktop"
            ];
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              hidden = [
                # "org.kde.plasma.brightness"
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
          "org.kde.plasma.showdesktop" 
        ];
      }
    
    ];

    powerdevil = {
      AC = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 900; # 15 minutes
        };
        powerButtonAction = "hibernate";
        powerProfile = "performance";
      };
      battery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 600; # 10 minutes
        };
        powerButtonAction = "hibernate";
        powerProfile = "balanced";
      };
      lowBattery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 300; # 5 minutes
        };
        powerButtonAction = "hibernate";
        powerProfile = "powerSaving";
      };
    };

    input = {
    
    };

  };
}

