{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "dwfv";
  version = "0.4.1";

  src = fetchCrate {
    inherit version pname;
    sha256 = "0xxgwbbbzaldbl04k5ksk61wa6i4f9mc84q04ljg438z0k8q6cr7";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A simple digital waveform viewer with vi-like key bindings";
    homepage = "https://github.com/psurply/dwfv";
    license = licenses.mit;
    maintainers = with maintainers; [ newam ];
  };
}
