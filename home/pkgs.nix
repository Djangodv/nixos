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
        # lutris
        libreoffice-qt # Qt framework is better suited for KDE Plasma
        pandoc
        texliveBasic # See: https://wiki.nixos.org/wiki/TexLive
        kdePackages.kdenlive # Video editor
        kdePackages.filelight
        # mc
    ];
}