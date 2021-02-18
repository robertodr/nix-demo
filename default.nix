let
  sources = import ./nix/sources.nix;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    direnv
    nvim
    python3.pkgs.numpy
    python3.pkgs.scipy
    python3.pkgs.jupyterlab
  ];
}
