{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, stdenv
, curl
, darwin
, git
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-release";
  version = "0.24.4";

  src = fetchFromGitHub {
    owner = "crate-ci";
    repo = "cargo-release";
    rev = "refs/tags/v${version}";
    hash = "sha256-6vl8aVZc1pLRXNWbwCWOg/W40TXe29CtXZy2uOLc5BQ=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "cargo-test-macro-0.1.0" = "sha256-N5jCEZRwucJU3y8kpNMeDzazcVQI3aTKAkBSgBRNHNg=";
      "cargo-test-support-0.1.0" = "sha256-N5jCEZRwucJU3y8kpNMeDzazcVQI3aTKAkBSgBRNHNg=";
      "cargo-util-0.2.2" = "sha256-N5jCEZRwucJU3y8kpNMeDzazcVQI3aTKAkBSgBRNHNg=";
      "crates-io-0.34.0" = "sha256-N5jCEZRwucJU3y8kpNMeDzazcVQI3aTKAkBSgBRNHNg=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    curl
    darwin.apple_sdk.frameworks.Security
  ];

  nativeCheckInputs = [
    git
  ];

  meta = with lib; {
    description = ''Cargo subcommand "release": everything about releasing a rust crate'';
    homepage = "https://github.com/crate-ci/cargo-release";
    changelog = "https://github.com/crate-ci/cargo-release/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ figsoda gerschtli ];
  };
}
