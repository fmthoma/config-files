{ pkgs, lib, ... }: {
  imports = [ ./home.nix ];

  home.packages = with pkgs; [
    blender
    discord
    freecad
    gmsh
    openscad
    unstable.super-slicer.beta
    telegram-desktop
    unstable.prusa-slicer
    release-24_11.vpype
  ];
}
