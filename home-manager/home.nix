{ pkgs, lib, config, ... }: {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    android-file-transfer
    android-tools
    arduino
    arduino-cli
    bc
    binutils
    chromium
    cloc
    delta
    dmenu
    evince
    evolution
    fasd
    feh
    freeplane
    ghcid
    nautilus
    google-chrome
    gucharmap
    release-22_11.haskellPackages.vgrep
    i3blocks
    i3lock
    i3status
    imagemagick
    release-24_11.imposevka
    inkscape
    release-24_11.iosevka
    jq
    keymap-visualizer
    libreoffice
    lsd
    meld
    msmtp
    mutt
    nload
    pandoc
    parallel
    pass
    pavucontrol
    petname
    powertop
    ranger
    restic
    stack
    stylish-haskell
    svgbob
    tig
    tldr
    tmux
    tree
    unzip
    v4l-utils
    vim
    vista-fonts
    vscode
    w3m
    xclip
    xdotool
    xkcdpass
    xsel
    yq
    zoom-us
  ];

  programs = {
      firefox.enable = true;
      firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
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
      tray = true;
    };
    picom.enable = true;
    poweralertd.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    pasystray.enable = true;
    syncthing.enable = true;
  };
  xdg.configFile."picom/picom.conf".text = lib.mkForce (lib.readFile ./picom.conf);

  gtk = {
    enable = true;
    iconTheme = {
      name = "HighContrast";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      icon-theme = "HighContrast";
      cursor-theme = "Adwaita";
      color-scheme = "prefer-light";
    };
  };
}
