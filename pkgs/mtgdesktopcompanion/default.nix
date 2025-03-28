{
  fetchFromGitHub,
  jre,
  makeWrapper,
  maven,
  makeDesktopItem,
}:
maven.buildMavenPackage rec {
  pname = "MtgDesktopCompanion";
  version = "2.53";

  src = fetchFromGitHub {
    owner = "nicho92";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "sha256-BnJi7OSPllW4Y5sCj/oEC/tz71TXHKjg0bT14nFDx48=";
  };

  mvnHash = "sha256-pRjYLjTxDUMncLKzeUXCHJZq9UW0xXdG+ggjoqdv3ZQ=";

  nativeBuildInputs = [maven makeWrapper];

  buildInputs = [jre];

  buildPhase = ''
    mvn -DskipTests clean install
  '';

  installPhase = ''
    mkdir -p $out/bin $out/lib
    mv target/executable/bin/*.sh $out/bin
    mv target/executable/lib $out

    wrapProgram $out/bin/mtg-desktop-companion.sh \
      --set JAVA_HOME ${jre} \
      --prefix PATH : ${jre}/bin
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "MtgDesktopCompanion";
      exec = "mtg-desktop-companion.sh";
      desktopName = "MtgDesktopCompanion";
      categories = ["Game"];
    })
  ];
}
