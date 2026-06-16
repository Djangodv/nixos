{ pkgs, ... }:
{
    home.packages = with pkgs; [
        spotify
        gimp
        tldr
        ripgrep
        fzf
        anki
        x11docker
        zip
        lutris
        libreoffice-qt # Qt framework is better suited for KDE Plasma
        pandoc
        texliveFull
        kdePackages.kdenlive
        kdePackages.filelight
        # mc
    ];
}