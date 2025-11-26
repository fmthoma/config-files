{ pkgs, lib, ... }: {
  imports = [ ./home.nix ];

  home.packages = with pkgs; [
    blender
    discord
    freecad
    gmsh
    openscad
    skypeforlinux
    unstable.super-slicer.beta
    tdesktop
    unstable.prusa-slicer
    vpype
  ];
}
