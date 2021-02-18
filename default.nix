let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (self: super: { })
    ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    direnv
    neovim
    python3.pkgs.numpy
    python3.pkgs.scipy
    python3.pkgs.jupyterlab
  ];
}
