{ pkgs, ... }: {
  home.stateVersion = "22.11";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    arduino
    arduino-cli
    awscli2
    bc
    binutils
    chromium
    cloc
    co2monitor
    discord
    dmenu
    evince
    fasd
    feh
    freecad
    ghcid
    gmsh
    gnome.nautilus
    google-chrome
    gucharmap
    i3blocks
    i3lock
    i3status
    imagemagick
    imposevka
    inkscape
    iosevka
    jq
    libreoffice
    lsd
    meld
    msmtp
    mutt-with-sidebar
    nload
    openscad
    pandoc
    parallel
    pass
    pavucontrol
    petname
    powertop
    ranger
    restic
    signal-desktop
    skypeforlinux
    slack
    stack
    stylish-haskell
    super-slicer
    svgbob
    tdesktop
    tig
    tldr
    tmux
    tree
    unzip
    vim
    vpype
    vscode
    w3m
    xclip
    xdotool
    xkcdpass
    xsel
    yq
    zoom
  ];

  programs = {
      firefox.enable = true;
      browserpass.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      configFile = ./dunstrc;
    };
    gammastep = {
      enable = true;
      latitude = 48.1;
      longitude = 11.6;
    };
    picom.enable = true;
    poweralertd.enable = true;
    network-manager-applet.enable = true;
  };
}
