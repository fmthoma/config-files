{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixpkgs, nixos, home-manager, ... }@inputs:
  let
    overlays = [
      (_: _: { unstable = import nixpkgs { system = "x86_64-linux"; inherit overlays; }; })
      (import ./nixpkgs/overlays/vpype)
      (import ./nixpkgs/overlays/iosevka)
      (import ./nixpkgs/overlays/petname.nix)
      (import ./nixpkgs/overlays/dmenu)
      (import ./nixpkgs/overlays/superslicer.nix)
    ];
    modules = {
      overlays = {
        config.nixpkgs = { inherit overlays; };
      };
      thomaf = {
        imports = [ home-manager.nixosModules.home-manager ];
        home-manager.useGlobalPkgs = true;
        home-manager.users.thomaf = import ./nixos/thomaf.nix;
      };
    };
  in {
    nixosConfigurations = {
      thomaf-t16 = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          modules.overlays
          modules.thomaf
          ./nixos/t16.nix
          ./nixos/configuration.nix
          ./nixos/hardware-configuration-t16.nix
        ];
      };
      thomaf-t460s = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          modules.overlays
          modules.thomaf
          ./nixos/t460s.nix
          ./nixos/configuration.nix
          ./nixos/hardware-configuration-t460s.nix
        ];
      };
    };
    packages.x86_64-linux = (import nixos { system = "x86_64-linux"; inherit overlays; });
  };
}
