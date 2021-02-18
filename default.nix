let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (self: super: {
        blas = super.blas.override {
          blasProvider = self.mkl;
        };
        lapack = super.lapack.override {
          lapackProvider = self.mkl;
        };
      })
    ];
  };
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
