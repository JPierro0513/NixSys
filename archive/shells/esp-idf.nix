{pkgs, ...}:
pkgs.mkShell {
  name = "esp-idf";
  buildInputs = with pkgs; [
    # (pkgs.callPackage ./pkgs/esp-toolchain.nix {})

    wget
    git
    gnumake
    flex
    bison
    gperf
    pkg-config
    clang-tools
    cmake
    ninja
    kconf
    ncurses
    (python3.withPackages (p:
      with p; [
        pip
        virtualenv
      ]))
  ];

  LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [libusb1 glibc];

  shellHook = ''
    export IDF_PATH=/home/jpierro/esp/esp-idf
    export PATH=$IDF_PATH/tools:$PATH
    $IDF_PATH/install.sh esp32s3
    . $IDF_PATH/export.sh
    cd $HOME/Projects/ESP
  '';
}
