{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "passerine";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "vrtbl";
    repo = "passerine";
    rev = "v${version}";
    hash = "sha256-TrbcULIJ9+DgQ4QsLYD5okxHoIusGJDw1PqJQwq1zu0=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A small extensible programming language designed for concise expression with little code";
    homepage = "https://www.passerine.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ siraben ];
  };
}
