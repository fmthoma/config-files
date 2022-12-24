{ config, pkgs, options, ... }: {
  config.services.udev.extraRules = ''
    ACTION=="remove", GOTO="co2mini_end"
    SUBSYSTEMS=="usb", KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="a052", GROUP="plugdev", MODE="0666", SYMLINK+="co2mini%n", GOTO="co2mini_end"
    LABEL="co2mini_end"
  '';
}
