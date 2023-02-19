{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, pkg-config
, curl
, libgit2
, openssl
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-raze";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ip0WuBn1b7uN/pAhOl5tfmToK73ZSHK7rucdtufsbCQ=";
  };
  sourceRoot = "source/impl";

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libgit2
    openssl
    curl
  ]
  ++ lib.optional stdenv.isDarwin Security;

  meta = with lib; {
    description = "Generate Bazel BUILD files from Cargo dependencies";
    homepage = "https://github.com/google/cargo-raze";
    license = licenses.asl20;
    maintainers = with maintainers; [ elasticdog ];
  };
}
