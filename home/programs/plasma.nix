{pkgs, ... }:
{

  # TODO: Add window rules

  programs.plasma = {
    enable = true;

    configFile = {
      # Accent color
      kdeglobals.General.AccentColor = "40,48,58";
      kdeglobals.General.LastUsedCustomAccentColor = "40,48,58";
      kwinrc.Desktops.Number = 2;
      # Remove the 'pin' icon on the applications bar
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "M";
      kwinrc."org.kde.kdecoration2".ButtonsOnRight = "IAX";
      kdeglobals.General.font = "Noto Sans,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop"; 
      iconTheme = "Tela-dark";
      wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
    };

    kscreenlocker = {
      appearance.wallpaper = /home/user/.local/share/wallpapers/pexels-eberhardgross-1612353.jpg;
    };

    shortcuts = {
      kwin."Grid View" = ["Meta+Tab" "Meta+G"];
      "services/firefox-esr.desktop"._launch = "Meta+F";
      "services/Alacritty.desktop"._launch = "Meta+Space";

      # Use KDE tiling editor to order window layout
      kwin."Window Custom Quick Tile Bottom" = "Meta+Down";
      kwin."Window Custom Quick Tile Left" = "Meta+Left";
      kwin."Window Custom Quick Tile Right" = "Meta+Right";
      kwin."Window Custom Quick Tile Top" = "Meta+Up";
      kwin."Window Quick Tile Bottom" = [ ];
      kwin."Window Quick Tile Left" = [ ];
      kwin."Window Quick Tile Right" = [ ];
      kwin."Window Quick Tile Top" = [ ];

      ksmserver."Lock Session" = "Screensaver";

      kwin."Switch Window Down" = ["Meta+J" "Meta+Alt+Down"];
      kwin."Switch Window Left" = ["Meta+Alt+Left" "Meta+H"];
      kwin."Switch Window Right" = ["Meta+L" "Meta+Alt+Right"];
      kwin."Switch Window Up" = ["Meta+Alt+Up" "Meta+K"];

      kwin."Window One Desktop to the Left" = ["Meta+Ctrl+Shift+Left" "Meta+Shift+Left"];
      kwin."Window One Desktop to the Right" = ["Meta+Ctrl+Shift+Right" "Meta+Shift+Right"];
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

    session.general.askForConfirmationOnLogout = false;

    panels = [

      # Windows-like panel at the bottom
      {

        location = "bottom";
        opacity = "opaque";
        # floating = false;
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

    input = {
    
    };

  };
}

