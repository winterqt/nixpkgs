{ lib, fetchFromGitHub, rustPlatform, pkg-config, openssl }:

with rustPlatform;

buildRustPackage rec {
  pname = "cfdyndns";
  version = "0.0.3";
  src = fetchFromGitHub {
    owner = "colemickens";
    repo = "cfdyndns";
    rev = "v${version}";
    sha256 = "1fba0w2979dmc2wyggqx4fj52rrl1s2vpjk6mkj1811a848l1hdi";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "CloudFlare Dynamic DNS Client";
    homepage = "https://github.com/colemickens/cfdyndns";
    license = lib.licenses.mit;
    maintainers = with maintainers; [ colemickens ];
    platforms = with platforms; linux;
  };
}
