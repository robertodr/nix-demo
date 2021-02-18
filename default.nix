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
    neovim
    python3.pkgs.numpy
    python3.pkgs.scipy
    python3.pkgs.jupyterlab
  ];

  shellHook = ''
    if [ ! -f $HOME/.dockerbuildphase ]; then
      touch $HOME/.dockerbuildphase
      export DOCKER_BUILD_PHASE=true
    fi

    if [ "$DOCKER_BUILD_PHASE" = true ]; then
      echo "Do some action in build phase"
      echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix
    fi

    if [ "$DOCKER_BUILD_PHASE" = false ]; then
      echo "Do some action in run phase like start db"
    fi

    echo "Do some action in both phases"
  '';
}
