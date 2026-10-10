{ config, pkgs, options, ... }: {
  programs.niri.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" ];
        "niri/workspaces" = {
          format = "{index}";
        };
        "clock" = {
          format = "{:%Y-%m-%d %H:%M}";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    swaybg
    swaylock
    wl-clipboard
    slurp
    grim
  ];
}
