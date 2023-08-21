{ config, pkgs, options, ... }: {
  config.environment.systemPackages = [ pkgs.xmobar ];
  config.services.xserver = {
    enable = true;
    layout = "de";
    xkbVariant = "neo";
    libinput.enable = true;
    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+xmonad";
      autoLogin = {
        user = "thomaf";
        enable = true;
      };
      sessionCommands = ''
        dbus-update-activation-environment --verbose --systemd --all
      '';
    };
    gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  };

  config.programs.dconf.enable = true;

  config.gtk.iconCache.enable = true;

  config.xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
