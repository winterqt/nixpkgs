{ fetchFromGitHub, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "ttyper";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "max-niederman";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-yReDHe5UJfBnEIhOp/3nHQkhp6YQQGDWqihLYi9IxdM=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Terminal-based typing test";
    homepage = "https://github.com/max-niederman/ttyper";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda max-niederman ];
  };
}
