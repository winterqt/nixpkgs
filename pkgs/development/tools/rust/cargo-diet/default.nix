{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-diet";
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "the-lean-crate";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-olF+F2y7F3ZpyluyslRDlfRKkWmE+zJ01bXyzy9x5EQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Help computing optimal include directives for your Cargo.toml manifest";
    homepage = "https://github.com/the-lean-crate/cargo-diet";
    changelog = "https://github.com/the-lean-crate/cargo-diet/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
