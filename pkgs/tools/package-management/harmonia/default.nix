{ lib
, boost
, fetchFromGitHub
, libsodium
, nix
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "harmonia";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "helsinki-systems";
    repo = pname;
    rev = "refs/tags/${pname}-v${version}";
    hash = "sha256-deqF6xDz3oCA1W8X8U1FD1gPYfxinZzpSuRKyaPDN/Y=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    boost
    libsodium
    nix
  ];

  meta = with lib; {
    description = "Nix binary cache";
    homepage = "https://github.com/helsinki-systems/harmonia";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
