{ lib
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "trust-dns";
  version = "0.22.0";

  src = fetchFromGitHub {
    owner = "bluejekyll";
    repo = "trust-dns";
    rev = "v${version}";
    sha256 = "sha256-b9tK1JbTwB3ZuRPh0wb3cOFj9dMW7URXIaFzUq0Yipw=";
  };
  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  # tests expect internet connectivity to query real nameservers like 8.8.8.8
  doCheck = false;

  meta = with lib; {
    description = "A Rust based DNS client, server, and resolver";
    homepage = "https://trust-dns.org/";
    maintainers = with maintainers; [ colinsane ];
    platforms = platforms.linux;
    license = with licenses; [ asl20 mit ];
  };
}
