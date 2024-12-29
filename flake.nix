{
  description = "Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};
      user = builtins.getEnv "USER";
    in
    {
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit nixpkgs;
        };
      };
    };
}
