{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "rustfilt";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "luser";
    repo = pname;
    rev = version;
    hash = "sha256-zb1tkeWmeMq7aM8hWssS/UpvGzGbfsaVYCOKBnAKwiQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Demangle Rust symbol names using rustc-demangle";
    homepage = "https://github.com/luser/rustfilt";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ wykurz ];
    mainProgram = "rustfilt";
  };
}
