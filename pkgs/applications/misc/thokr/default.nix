{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "thokr";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "thatvegandev";
    repo = pname;
    rev = "v${version}";
    sha256 = "0aryfx9qlnjdq3iq2d823c82fhkafvibmbz58g48b8ah5x5fv3ir";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A typing tui with visualized results and historical logging";
    homepage = "https://github.com/thatvegandev/thokr";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
