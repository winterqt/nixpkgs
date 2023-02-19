{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "fblog";
  version = "4.2.0";

  src = fetchFromGitHub {
    owner = "brocode";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-A5/TwISGsk9L0Z/ZF9Z/fxiMG+rcPgtAr2BNVJ+1Xfo=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A small command-line JSON log viewer";
    homepage = "https://github.com/brocode/fblog";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ figsoda ];
  };
}
