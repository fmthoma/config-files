{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-22_05.url = "github:nixos/nixpkgs/release-22.05";
    nixpkgs-21_11.url = "github:nixos/nixpkgs/release-21.11";
    nixpkgs-21_05.url = "github:nixos/nixpkgs/release-21.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixos, home-manager, ... }@inputs:
  let
    overlays = [
      (_: _: {
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; inherit overlays; };
        release-22_05 = import inputs.nixpkgs-22_05 { system = "x86_64-linux"; inherit overlays; };
        release-21_11 = import inputs.nixpkgs-21_11 { system = "x86_64-linux"; inherit overlays; };
        release-21_05 = import inputs.nixpkgs-21_05 { system = "x86_64-linux"; inherit overlays; };
      })
      (import ./nixpkgs/overlays/co2monitor)
      (import ./nixpkgs/overlays/dmenu)
      (import ./nixpkgs/overlays/iosevka)
      (import ./nixpkgs/overlays/petname.nix)
      (import ./nixpkgs/overlays/superslicer.nix)
      (import ./nixpkgs/overlays/throttled.nix)
      (import ./nixpkgs/overlays/vpype)
    ];
    modules = {
      overlays = {
        config.nixpkgs = { inherit overlays; };
      };
      home = username: {
        imports = [ home-manager.nixosModules.home-manager ];
        home-manager.useGlobalPkgs = true;
        home-manager.users.${username} = import ./home-manager/home.nix;
      };
    };
  in {
    nixosConfigurations = {
      thomaf-t16 = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          modules.overlays
          (modules.home "thomaf")
          ./nixos/machines/t16.nix
          ./nixos/machines/hardware-configuration-t16.nix
          ./nixos/configuration.nix
          ./nixos/modules/thomaf.nix
          ./nixos/modules/docker.nix
          ./nixos/modules/thinkpad.nix
          ./nixos/modules/xserver.nix
        ];
      };
      thomaf-t460s = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          modules.overlays
          (modules.home "thomaf")
          ./nixos/machines/t460s.nix
          ./nixos/machines/hardware-configuration-t460s.nix
          ./nixos/configuration.nix
          ./nixos/modules/thomaf.nix
          ./nixos/modules/keybase.nix
          ./nixos/modules/thinkpad.nix
          ./nixos/modules/xserver.nix
        ];
      };
    };
    packages.x86_64-linux = (import nixos { system = "x86_64-linux"; inherit overlays; });
  };
}
