{ config, pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    policies = {
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = {
            importedLists = [];
          };
          # Source: https://www.reddit.com/r/firefox/comments/1dt5yte/you_should_know_the_extension_still_dont_care/
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "adguard-spyware-url"
            "urlhaus-1"
            "plowe-0"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "ublock-annoyances"
          ];
        };
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          private_browsing = true;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          private_browsing = true; 
        };
        "myallychou@gmail.com" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          private_browsing = true; 
        };
      };
      ExtensionUpdate = true;
      Homepage = {
        Locked = true;
        StartPage = "none";
      };
      NewTabPage = false;
      PictureInPicture = {
        Enabled = false;
      };
      SearchSuggestEnabled = false;
      OfferToSaveLogins = false;
      DisableFormHistory = true;
      SanitizeOnShutdown = {
        Cache = false;
        Cookies = false;
        FormData = true;
        History = true;
        # Sessions = false;
        SiteSettings = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      PasswordManagerEnabled = false;
      DisplayBookmarksToolbar = "never";
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboardin = false;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
      GenerativeAI = {
        Enabled = false;
        Locked = true;
      };
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
      settings = {
        # Enable vertical tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        # See https://librewolf.net/docs/faq/#how-do-i-fully-prevent-autoplay for options
        "media.autoplay.blocking_policy" = 2;
        "browser.compactmode.show" = true;
        # TODO: Below needs testing
        # "browser.uiCustomization.navBarWhenVerticalTabs" = ''["sidebar-button","back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","save-to-pocket-button","downloads-button","fxa-toolbar-menu-button","unified-extensions-button"]'';
      };
    };
  };

  home.file.".mozilla/firefox/default/places.sqlite" = {
    source = config.lib.file.mkOutOfStoreSymlink "~/Github/nixos/places.sqlite";
    force = true;
  };
  
}

# Sources for configuration:
# - https://nix-community.github.io/home-manager/options.xhtml
# - https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix
# - https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/desktop/common/firefox.nix
# - https://github.com/Kreyren/nixos-config/blob/bd4765eb802a0371de7291980ce999ccff59d619/nixos/users/kreyren/home/modules/web-browsers/firefox/firefox.nix#L116-L148 
