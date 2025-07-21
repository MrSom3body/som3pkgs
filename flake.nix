{
  description = "a dev template to use nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    inherit (self) outputs;

    forEachSystem = f: lib.genAttrs (import inputs.systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import inputs.systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    packages = forEachSystem (pkgs:
      import ./pkgs {
        inherit outputs inputs pkgs;
      });

    devShells = forEachSystem (pkgs:
      import ./nix/shell.nix {
        inherit self;
        inherit pkgs;
      });

    checks = forEachSystem (pkgs:
      import ./nix/checks.nix {
        inherit inputs;
        inherit pkgs;
      });

    homeManagerModules = import ./modules/home {inherit outputs;};
  };
}
