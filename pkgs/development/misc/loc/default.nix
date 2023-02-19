{ lib, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage rec {
  version = "0.4.1";
  pname = "loc";

  src = fetchFromGitHub {
    owner = "cgag";
    repo = "loc";
    rev = "v${version}";
    sha256 = "0086asrx48qlmc484pjz5r5znli85q6qgpfbd81gjlzylj7f57gg";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    homepage = "https://github.com/cgag/loc";
    description = "Count lines of code quickly";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = platforms.unix;
  };
}
