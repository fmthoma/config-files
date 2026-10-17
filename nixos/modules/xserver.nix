{ config, pkgs, options, ... }: {
  config.services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "neo";
      };
      windowManager = {
        i3.enable = true;
      };
      displayManager = {
        sessionCommands = ''
          if test -e $HOME/.Xresources; then
            ${pkgs.xrdb}/bin/xrdb --merge $HOME/.Xresources
          fi
        '';
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
        settings.General.GreeterEnvironment = "WLR_NO_HARDWARE_CURSORS=1,KWIN_FORCE_SW_CURSOR=1";
        settings.Theme = {
          CursorTheme = "Adwaita";
          CursorSize = 24;
        };
      };
      defaultSession = "none+i3";
    };
    libinput.enable = true;
  };
  config.environment.systemPackages = [ pkgs.adwaita-icon-theme ];
  config.environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
