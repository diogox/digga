{
  description = "A highly structured configuration database.";

  epoch = 201909;

  inputs.nixpkgs.url = "github:nrdxp/nixpkgs/fork";
  inputs.home.url = "github:nrdxp/home-manager/flakes";

  outputs = { self, home, nixpkgs, nix }: {
    nixosConfigurations =
      let
        configs = import ./configurations {
          inherit nix nixpkgs;
          flake = self;
          home = home.nixosModules.home-manager;
        };

      in
        configs;

  };

}