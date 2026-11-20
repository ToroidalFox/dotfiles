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
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref-latest";

    mitos = {
      url = "github:mitos-editor/mitos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }@inputs:
  let
    username = "toroidalfox";

    profiles = {
      min = { development = false; desktop = false; };
      dev = { development = true; desktop = false; };
      full = { development = true; desktop = true; };
    };

    mkHome = { system, profile }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs username profile;
          isLinux = nixpkgs.lib.hasSuffix "-linux" system;
          isDarwin = nixpkgs.lib.hasSuffix "-darwin" system;
        };
        modules = [
          ./modules/common.nix
          ./modules/development.nix
        #   ./home/desktop.nix
        ] ++ nixpkgs.lib.optionals (nixpkgs.lib.hasSuffix "-linux" system) [
          ./modules/linux.nix
        # ] ++ nixpkgs.lib.optionals (nixpkgs.lib.hasSuffix "-darwin" system) [
        #   ./home/darwin.nix
        ];
      };

    mkLinuxHomes = { system, archAlias }:
      nixpkgs.lib.mapAttrs' (name: profile: {
        name = "linux-${archAlias}-${name}";
        value = mkHome {
          inherit system profile;
        };
      }) profiles;

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
    homeConfigurations =
      (mkLinuxHomes {
        system = "x86_64-linux";
        archAlias = "x8";
      }) //
      (mkLinuxHomes {
        system = "aarch64-linux";
        archAlias = "a8";
      });
    /*
    darwinConfigurations = {
    }; */
  };
}
