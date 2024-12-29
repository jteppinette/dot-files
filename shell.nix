let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { };
in

pkgs.mkShell {
  packages = [ pkgs.home-manager ];
  shellHook = ''
    	export HOME_MANAGER_CONFIG="./home.nix"
    	export NIX_PATH="nixpkgs=${nixpkgs}"

  '';
}
