{
  description = "Simple session management";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      plugin-overlay = final: prev: {
        session-nvim = final.pkgs.vimUtils.buildVimPlugin {
          name = "session.nvim";
          src = self;
        };
      };

      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            plugin-overlay
          ];
        };
      in
      {
        packages = rec {
          default = session-nvim;
          inherit (pkgs) session-nvim;
        };
      }
    )
    // {
      overlays.default = plugin-overlay;
    };
}
