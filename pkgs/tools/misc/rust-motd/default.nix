{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, stdenv
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "rust-motd";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "rust-motd";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-w984vvjjieSv4eM3jT8zJIIR7/7pmADhR3Esj+2dCTs=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    Security
  ];

  OPENSSL_NO_VENDOR = 1;

  meta = with lib; {
    description = "Beautiful, useful MOTD generation with zero runtime dependencies";
    homepage = "https://github.com/rust-motd/rust-motd";
    changelog = "https://github.com/rust-motd/rust-motd/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
