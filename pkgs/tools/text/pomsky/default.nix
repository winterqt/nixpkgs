{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "pomsky";
  version = "0.9";

  src = fetchFromGitHub {
    owner = "rulex-rs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-SR+cXCPcEejX3AauN3mS6zWU46m4nomMs1UVk+si1NY=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "criterion-0.3.6" = "sha256-biFm0+AjKLwV9yHgCaK6E6L6W+6sRbnY2QOKVhv/1C8=";
      "criterion-plot-0.4.5" = "sha256-biFm0+AjKLwV9yHgCaK6E6L6W+6sRbnY2QOKVhv/1C8=";
    };
  };

  # thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: invalid option '--test-threads''
  doCheck = false;

  meta = with lib; {
    description = "A portable, modern regular expression language";
    homepage = "https://pomsky-lang.org";
    changelog = "https://github.com/rulex-rs/pomsky/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
