{ pkgs, lib, ... }: {
  imports = [ ./home.nix ];

  home.packages = with pkgs; [
    blender
    discord
    freecad
    gmsh
    openscad
    skypeforlinux
    super-slicer
    tdesktop
    unstable.prusa-slicer
  ];
}
