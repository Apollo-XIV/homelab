{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nur, stylix, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
          nur.nixosModules.nur
          ({pkgs, ...}: {
            nixpkgs.overlays = [nur.overlay];
            imports = [
              ./hosts/default/configuration.nix
            ];
          })    
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.users.acrease = {
            #   imports = [
            #     hyprlock.homeManagerModules.hyprlock
            #   ];
            # };
          }
        ];
      };
      salas = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/salas/configuration.nix
        ];
      };
      live-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-gnome.nix"
          ({pkgs, ...}: {
            environment.systemPackages = [pkgs.git];
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          })
        ];
      };
    };
  };
}
