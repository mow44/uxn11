{
  description = "uxn11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage.${system} =
        with pkgs;
        stdenv.mkDerivation {
          name = "uxn11";
          version = "main";

          nativeBuildInputs = with pkgs; [
            xorg.libX11
          ];

          src = pkgs.fetchFromSourcehut {
            owner = "~rabbits";
            repo = "uxn11";
            rev = "c7f40c7021fac1de5eeb2fbe95b17caa46655132";
            hash = "sha256-ylqZLmdET2YqZcneZArZo5F3TTir5BClfMPnnbkfSys="; # lib.fakeHash;
          };

          installPhase = ''
            mkdir -p $out/bin
            cp bin/uxn11 bin/uxncli $out/bin

            mkdir -p $out/share/man/man7
            cp doc/man/uxntal.7 $out/share/man/man7
          '';
        };
    };
}
