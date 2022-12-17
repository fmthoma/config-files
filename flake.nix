{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos, home-manager, ... }@inputs: {
    nixosConfigurations = {
      fthoma-nixos = self.nixosConfigurations.thomaf-t16;
      thomaf-t16 = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./etc/nixos/t16.nix
          ./etc/nixos/configuration.nix
          ./etc/nixos/hardware-configuration-t16.nix
          (import ./etc/nixos/thomaf.nix home-manager)
        ];
      };
      thomaf-t460s = nixos.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./etc/nixos/t460s.nix
          ./etc/nixos/configuration.nix
          ./etc/nixos/hardware-configuration-t460s.nix
          ./etc/nixos/thomaf.nix
        ];
      };
    };
  };
}
