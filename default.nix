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

  shellHook = ''
    if [ ! -f $HOME/.dockerbuildphase ]; then
      touch $HOME/.dockerbuildphase
      export DOCKER_BUILD_PHASE=true
    fi
    if [ "$DOCKER_BUILD_PHASE" = true ]; then
      echo "Do some action in build phase"
    fi
    if [ "$DOCKER_BUILD_PHASE" = false ]; then
      echo "Do some action in run phase like start db"
      echo "{ allowUnfree = true; }" > ~/.config/nixpkgs/config.nix
    fi
    echo "Do some action in both phases"
  '';
}
