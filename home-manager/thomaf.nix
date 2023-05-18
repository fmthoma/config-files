{ pkgs, lib, ... }: {
  imports = [ ./home.nix ];

  home.packages = with pkgs; [
    awscli2
    jetbrains.idea-ultimate
    slack
  ];
}
