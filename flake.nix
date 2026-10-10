{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-25_05.url = "github:nixos/nixpkgs/release-25.05";
    nixpkgs-24_11.url = "github:nixos/nixpkgs/release-24.11";
    nixpkgs-22_11.url = "github:nixos/nixpkgs/release-22.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
    keymap-visualizer.url = "github:fmthoma/keymap-visualizer/main";
  };

  outputs = { self, nixos, home-manager, ... }@inputs:
  let
    overlays = [
      (_: _: {
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; inherit overlays; };
        release-25_05 = import inputs.nixpkgs-25_05 { system = "x86_64-linux"; inherit overlays; };
        release-24_11 = import inputs.nixpkgs-24_11 { system = "x86_64-linux"; inherit overlays; };
        release-22_11 = import inputs.nixpkgs-22_11 { system = "x86_64-linux"; inherit overlays; };
      })
      (import ./nixpkgs/overlays/dmenu)
      (import ./nixpkgs/overlays/iosevka)
      (import ./nixpkgs/overlays/petname.nix)
      (import ./nixpkgs/overlays/vpype)
      (inputs.keymap-visualizer.overlays.default)
    ];
    modules = {
      overlays = {
        config.nixpkgs = { inherit overlays; };
      };
      home = username: {
        imports = [
          home-manager.nixosModules.home-manager
          ./nixos/modules/${username}.nix
        ];
        home-manager.useGlobalPkgs = true;
        home-manager.users.${username} = import ./home-manager/${username}.nix;
      };
    };
  in {
    nixosConfigurations = {
      thomaf-t16 = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          modules.overlays
          (modules.home "thomaf")
          (modules.home "privat")
          ./nixos/machines/t16.nix
          ./nixos/machines/hardware-configuration-t16.nix
          ./nixos/configuration.nix
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
          ./nixos/modules/keybase.nix
          ./nixos/modules/thinkpad.nix
          ./nixos/modules/xserver.nix
        ];
      };
    };
    packages.x86_64-linux = (import nixos {
      system = "x86_64-linux";
      inherit overlays;
      config.allowUnfree = true;
    });
  };
}
