{
  description = "Language server for Odin";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (
        system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [self.overlays.default];
            };
          }
      );
  in {
    overlays.default = final: prev: {
      odin = prev.odin.overrideAttrs rec {
        version = "dev-2025-12";

        src = prev.fetchFromGitHub {
          owner = "odin-lang";
          repo = "Odin";
          tag = version;
          hash = "sha256-YN/HaE8CD9xQzRc2f07aBy/sMReDj1O+U0+HPKBYFmQ=";
        };
      };
    };

    devShells = forEachSupportedSystem (
      {pkgs}:
        with pkgs; {
          default = mkShell {
            packages = [
              odin
              nixd
              alejandra
              vscode-json-languageserver

              (writeShellScriptBin "ols" ''
                ./ols "$@"
              '')

              (writeShellScriptBin "odinfmt" ''
                ./odinfmt "$@"
              '')

              (writeShellScriptBin "build" ''
                odin build src/ -show-timings -collection:src=src -out:ols "$@"
              '')
            ];
          };
        }
    );
  };
}
