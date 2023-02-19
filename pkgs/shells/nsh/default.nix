{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "nsh";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "nuta";
    repo = pname;
    rev = "v${version}";
    sha256 = "1479wv8h5l2b0cwp27vpybq50nyvszhjxmn76n2bz3fchr0lrcbp";
  };

  cargoLock.lockFile = ./Cargo.lock;

  doCheck = false;

  meta = with lib; {
    description = "A command-line shell like fish, but POSIX compatible";
    homepage = "https://github.com/nuta/nsh";
    changelog = "https://github.com/nuta/nsh/raw/v${version}/docs/changelog.md";
    license = [ licenses.cc0 /* or */ licenses.mit ];
    maintainers = [ maintainers.marsam ];
  };

  passthru = {
    shellPath = "/bin/nsh";
  };
}
