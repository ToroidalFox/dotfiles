{
  description = "Personal mono flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    mitos = {
      url = "github:mitos-editor/mitos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }@inputs:
  let
    username = "toroidalfox";
    arches = ["x86_64" "aarch64"];
    presets = {
      min = { development = false; desktop = false; };
      dev = { development = true; desktop = false; };
      full = { development = true; desktop = true; };
    };

    mkLinuxHome = { system, preset }:
    let
      isLinux = true;
      isDarwin = false;
    in
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs username isLinux isDarwin;
        };
        modules = [
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ./modules/common.nix
          ./modules/linux.nix
        ] ++ nixpkgs.lib.optionals preset.development [
          ./modules/development.nix
        ] ++ nixpkgs.lib.optionals preset.desktop [
          ./modules/desktop-linux.nix
        ];
      };

    /*
    mkDarwin = { profileName, profile }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs username profile;
        };
        modules = [
          ./modules/darwin/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs username;
                isLinux = false;
                isDarwin = true;
                profiles = profile;
              };
              users.${username}.imports = [
                ./modules/home/common.nix
                ./modules/home/development.nix
                ./modules/home/desktop.nix
                ./modules/home/darwin.nix
                # add more modules here too
              ];
            };
          }
        ];
      }; */
  in {
    homeConfigurations = nixpkgs.lib.listToAttrs (nixpkgs.lib.concatMap (arch:
      nixpkgs.lib.mapAttrsToList(configName: preset: {
        name = "linux-${arch}-${configName}";
        value = mkLinuxHome {
          system = "${arch}-linux";
          inherit preset;
        };
      }) presets
    ) arches);
    /*
    darwinConfigurations = {
    }; */
  };
}
