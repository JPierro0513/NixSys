{pkgs, ...}: {
  pname = "witchblast";
  version = "0.7.5";
  src = pkgs.fetchFromGithub {
    owner = "Cirrus-Minor";
    repo = "witchblast";
    sha256 = "XWruIdbxIns2MZoKWCl3Yfd9ns4AECAQRsl0hMZgV+I=";
  };
  buildInputs = with pkgs; [
    cmake
    sfml
  ];
  installPhase = ''
    mkdir -p $out/bin
    install Witch_Blast $out/bin/Witch_Blast
    cp -r ../media $out/media
    cp -r ../data $out/data
  '';
}
