{ lib, rustPlatform, fetchFromGitHub, testers, cbfmt }:

rustPlatform.buildRustPackage rec {
  pname = "cbfmt";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "lukas-reineke";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-/ZvL1ZHXcmE1n+hHvJeSqmnI9nSHJ+zM9lLNx0VQfIE=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  passthru.tests.version = testers.testVersion {
    package = cbfmt;
  };

  meta = with lib; {
    description = "A tool to format codeblocks inside markdown and org documents";
    homepage = "https://github.com/lukas-reineke/cbfmt";
    license = licenses.mit;
    maintainers = [ maintainers.stehessel ];
  };
}
