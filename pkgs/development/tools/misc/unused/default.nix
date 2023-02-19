{ lib, fetchFromGitHub, rustPlatform, cmake }:
rustPlatform.buildRustPackage rec {
  pname = "unused";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "unused-code";
    repo = pname;
    rev = version;
    sha256 = "sha256-+1M8dUfjjrT4llS0C6WYDyNxJ9QZ5s9v+W185TbgwMw=";
  };

  nativeBuildInputs = [ cmake ];

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A tool to identify potentially unused code";
    homepage = "https://unused.codes";
    license = licenses.mit;
    maintainers = [ ];
  };
}
