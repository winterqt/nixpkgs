{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "lscolors";
  version = "0.13.0";

  src = fetchCrate {
    inherit version pname;
    sha256 = "sha256-rs/qv6zmSHy2FFiPSgGzxAV/r0SqK9vnfwnLj45WY4I=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  # setid is not allowed in the sandbox
  checkFlags = [ "--skip=tests::style_for_setid" ];

  meta = with lib; {
    description = "Rust library and tool to colorize paths using LS_COLORS";
    homepage = "https://github.com/sharkdp/lscolors";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
