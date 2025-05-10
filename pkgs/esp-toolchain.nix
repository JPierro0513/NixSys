{
  stdenv,
  fetchurl,
  makeWrapper,
  buildFHSEnv,
}: let
  fhsEnv = buildFHSEnv {
    name = "esp-toolchain-env";
    targetPkgs = pkgs: with pkgs; [zlib];
    # runScript = "";
  };
in
  stdenv.mkDerivation rec {
    pname = "esp-toolchain";
    version = "14.2.0_20241119";

    src = fetchurl {
      url = "https://github.com/espressif/crosstool-NG/releases/download/esp-${version}/xtensa-esp-elf-${version}-x86_64-linux-gnu.tar.gz";
      hash = "";
    };

    buildInputs = [makeWrapper];

    phases = ["unpackPhase" "installPhase"];

    installPhase = ''
      cp -r . $out
      for FILE in $(ls $out/bin); do
        FILE_PATH="$out/bin/$FILE"
        if [[ -x $FILE_PATH ]]; then
          mv $FILE_PATH $FILE_PATH-unwrapped
          makeWrapper ${fhsEnv}/bin/esp-toolchain-env $FILE_PATH --add-flags "$FILE_PATH-unwrapped"
        fi
      done
    '';
  }
