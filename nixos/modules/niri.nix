{ config, pkgs, options, ... }: {
  programs.niri.enable = true;

  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    grim
    niri-float-sticky
    niri-scratchpad
    slurp
    swaybg
    swaylock
    wl-clipboard
    xwayland-satellite
  ];
}
