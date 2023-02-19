{ lib, stdenv, fetchFromGitHub, rustPlatform, Security }:

rustPlatform.buildRustPackage rec {
  pname = "diffr";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "mookid";
    repo = pname;
    rev = "v${version}";
    sha256 = "18ks5g4bx6iz9hdjxmi6a41ncxpb1hnsscdlddp2gr40k3vgd0pa";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = (lib.optional stdenv.isDarwin Security);

  preCheck = ''
    export DIFFR_TESTS_BINARY_PATH=$releaseDir/diffr
  '';

  meta = with lib; {
    description = "Yet another diff highlighting tool";
    homepage = "https://github.com/mookid/diffr";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ davidtwco ];
  };
}
