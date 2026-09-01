{
  description = "Flatpak development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              flatpak
              flatpak-builder
              wget
              ostree
            ];
          };
        }
      );

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          import-bundle = pkgs.writeShellScriptBin "import-bundle" ''
            VERSION=0.1.22-alpha
            wget https://github.com/NuvioMedia/NuvioDesktop/releases/download/$VERSION/Nuvio-Linux-x86_64-$VERSION.flatpak
            flatpak build-import-bundle repo Nuvio-Linux-x86_64-$VERSION.flatpak
            flatpak build-update-repo --generate-static-deltas --prune repo
            rm Nuvio-Linux-x86_64-$VERSION.flatpak
          '';
          default = self.packages.${system}.import-bundle;
        }
      );
    };
}
