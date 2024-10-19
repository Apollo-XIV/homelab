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
    pkl.url = "github:capslock/pkl-flake";
    lampray.url = "github:Apollo-XIV/nix-lampray";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nur, stylix, pkl, lampray, nix-on-droid, ... }@inputs: {
    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration{
      pkgs = import nixpkgs { system = "aarch64-linux"; };
      modules = [
        ./hosts/nix-on-droid/config.nix
      ];
    };
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
          nur.nixosModules.nur
          ({pkgs, ...}: {
            nixpkgs.overlays = [
              nur.overlay
              lampray.overlay
              (import ./overlays/programs.nix)
            ];
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
          inputs.home-manager.nixosModules.default
          nur.nixosModules.nur
          ({pkgs, ...}: {
            nixpkgs.overlays = [
              nur.overlay
              (import ./overlays/programs.nix)
            ];
            imports = [
              ./hosts/salas/configuration.nix
            ];
          })    
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
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
