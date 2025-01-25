{
  user,
  home,
  inputs,
  ...
}:
{
  nix = {
    linux-builder = {
      enable = true;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      ephemeral = true;
    };
    settings = {
      trusted-users = [ "@admin" ];
      experimental-features = "nix-command flakes";
    };
  };

  users.users.${user}.home = home;

  system.stateVersion = 5;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user home; };
    users.${user} = import ./home.nix;
    sharedModules = [ inputs.mac-app-util.homeManagerModules.default ];
  };
}
