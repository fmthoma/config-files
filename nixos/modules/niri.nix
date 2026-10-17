{ config, pkgs, options, ... }: {
  programs.niri.enable = true;

  programs.waybar.enable = true;

  environment.sessionVariables = {
    EDITOR = "vim";
    PAGER = "less";
    PATH = [
      "$HOME/bin"
      "$HOME/config-files/bin"
      "$HOME/.local/bin"
      "$HOME/.cabal/bin"
      "$HOME/.ghcup/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    grim
    niri-float-sticky
    niri-scratchpad
    slurp
    swaybg
    swaylock
    wdisplays
    wl-clipboard
    xwayland-satellite
  ];
}
