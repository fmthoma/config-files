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
        wayland.enable = true;
      };
      defaultSession = "none+i3";
    };
    libinput.enable = true;
  };
}
