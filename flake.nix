{
  description = "Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    mac-app-util.url = "github:hraban/mac-app-util/548672d0cb661ce11d08ee8bde92b87d2a75c872";

    system-manager = {
      url = "github:numtide/system-manager?rev=c9e35e9b7d698533a32c7e34dfdb906e1e0b7d0a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics?rev=5a8d749e977090c7f8c5b920b13262174b2d7b55";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, system-manager, nix-system-graphics, flake-utils, mac-app-util, ... }:

    flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ]
      (system: {
        systemConfigs = system-manager.lib.makeSystemConfig {
          modules = [
            nix-system-graphics.systemModules.default
            ({
              nixpkgs.hostPlatform = system;
              system-graphics.enable = true;
            })
          ];
        };
      })

    //

    (
      let
        pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};
        user = "jteppinette";
        home = with pkgs.stdenv;
          if isLinux then "/home/${user}"
          else if isDarwin then "/Users/${user}"
          else throw "unsupported system: ${system}";
      in
      {
        homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;

            modules = [
              mac-app-util.homeManagerModules.default
              ./home.nix
            ];
            extraSpecialArgs = {
              inherit nixpkgs user home;
            };
          };
      }
    );

}
