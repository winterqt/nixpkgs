{ lib
, stdenv
, rustPlatform
, fetchCrate
}:
rustPlatform.buildRustPackage rec {
  pname = "cfonts";
  version = "1.1.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-STeLEHgggshhyLCfqiJmDcmwxqQ1AOGHj2ATliEY+DA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    homepage = "https://github.com/dominikwilkowski/cfonts";
    description =
      "A silly little command line tool for sexy ANSI fonts in the console";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ leifhelm ];
  };
}
