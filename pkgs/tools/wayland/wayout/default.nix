{ lib
, stdenv
, fetchFromSourcehut
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "wayout";
  version = "1.1.3";

  src = fetchFromSourcehut {
    owner = "~shinyzenith";
    repo = pname;
    rev = version;
    sha256 = "sha256-EzRetxx0NojhBlBPwhQ7p9rGXDUBlocVqxcEVGIF3+0=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Simple output management tool for wlroots based compositors implementing";
    homepage = "https://git.sr.ht/~shinyzenith/wayout";
    license = licenses.bsd2;
    maintainers = with maintainers; [ onny ];
    platforms = platforms.linux;
  };

}
