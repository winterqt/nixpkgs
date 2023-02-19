{ lib, stdenv, fetchCrate, rustPlatform }:

rustPlatform.buildRustPackage rec {
  version = "8.0.0";
  pname = "oxipng";

  src = fetchCrate {
    inherit version pname;
    hash = "sha256-stTwsU9XK3lF4q2sDgb9A1KG1NnhCfVxYWRiBvlmiqQ=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  doCheck = !stdenv.isAarch64 && !stdenv.isDarwin;

  meta = with lib; {
    homepage = "https://github.com/shssoichiro/oxipng";
    description = "A multithreaded lossless PNG compression optimizer";
    license = licenses.mit;
    maintainers = with maintainers; [ dywedir ];
  };
}
