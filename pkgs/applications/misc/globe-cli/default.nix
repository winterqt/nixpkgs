{ lib, stdenv, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "globe-cli";
  version = "0.2.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-Np1f/mSMIMZU3hE0Fur8bOHhOH3rZyroGiVAqfiIs7g=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Display an interactive ASCII globe in your terminal";
    homepage = "https://github.com/adamsky/globe";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ devhell ];
    mainProgram = "globe";
  };
}
