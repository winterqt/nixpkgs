{ lib
, rustPlatform
, fetchCrate
, pkg-config
, libgit2
, openssl
, zlib
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "panamax";
  version = "1.0.12";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-nHAsKvNEhGDVrLx8K7xnm7TuCxaZcYwlQ6xjVRvDdSk=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libgit2
    openssl
    zlib
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  meta = with lib; {
    description = "Mirror rustup and crates.io repositories for offline Rust and cargo usage";
    homepage = "https://github.com/panamax-rs/panamax";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
