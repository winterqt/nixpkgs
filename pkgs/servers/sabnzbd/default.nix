{ lib
, stdenv
, fetchFromGitHub
, python3
, par2cmdline
, unzip
, unrar
, p7zip
, makeWrapper
, nixosTests
}:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    chardet
    cheetah3
    cherrypy
    cryptography
    configobj
    feedparser
    sabctools
    puremagic
    guessit
    pysocks
  ]);
  path = lib.makeBinPath [ par2cmdline unrar unzip p7zip ];
in
stdenv.mkDerivation rec {
  version = "4.0.1";
  pname = "sabnzbd";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    hash = "sha256-7g+a0J9AnfowXYRw2JvY5EJ9aOB5IA4Fks84jIAv9Hc=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ pythonEnv ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -R * $out/
    mkdir $out/bin
    echo "${pythonEnv}/bin/python $out/SABnzbd.py \$*" > $out/bin/sabnzbd
    chmod +x $out/bin/sabnzbd
    wrapProgram $out/bin/sabnzbd --set PATH ${path}

    runHook postInstall
  '';

  passthru.tests = {
    smoke-test = nixosTests.sabnzbd;
  };

  meta = with lib; {
    description = "Usenet NZB downloader, par2 repairer and auto extracting server";
    homepage = "https://sabnzbd.org";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with lib.maintainers; [ fridh jojosch ];
  };
}
