{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "keepass-diff";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "Narigo";
    repo = pname;
    rev = version;
    sha256 = "sha256-jd/cUkTHylLwzxolQUzMlXHauCfXUhcUr/1zKpdngbo=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A CLI-tool to diff Keepass (.kdbx) files";
    homepage = "https://keepass-diff.narigo.dev/";
    license = licenses.mit;
    maintainers = with maintainers; [ wamserma ];
  };
}
