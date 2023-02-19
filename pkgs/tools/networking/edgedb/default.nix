{ stdenv
, lib
, runCommand
, patchelf
, fetchFromGitHub
, rustPlatform
, makeWrapper
, pkg-config
, curl
, Security
, CoreServices
, libiconv
, xz
, perl
, substituteAll
}:

rustPlatform.buildRustPackage rec {
  pname = "edgedb";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "edgedb";
    repo = "edgedb-cli";
    rev =  "v${version}";
    sha256 = "sha256-U+fF0t+dj8wUfCviNu/zcoz3lhMXcQlDgz8B3gB+EJI=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "assert_cmd-1.0.1" = "sha256-0MkQG+JKrZXOn8B8q1HdyhZ1hVVb7dPbGEo/76o2YRc=";
      "edgedb-client-0.3.0" = "sha256-2Ej2sdEMX9lKWJR9C8D/gIkewyHPPbY7HJaYs6VyJ2g=";
      "edgedb-derive-0.3.0" = "sha256-2Ej2sdEMX9lKWJR9C8D/gIkewyHPPbY7HJaYs6VyJ2g=";
      "edgedb-errors-0.2.1" = "sha256-2Ej2sdEMX9lKWJR9C8D/gIkewyHPPbY7HJaYs6VyJ2g=";
      "edgedb-protocol-0.3.0" = "sha256-2Ej2sdEMX9lKWJR9C8D/gIkewyHPPbY7HJaYs6VyJ2g=";
      "edgeql-parser-0.1.0" = "sha256-zWo5/ikoTZF17ABOwodygE3ygn0cGcwQ5B7KyarWIqA=";
      "rexpect-0.3.0" = "sha256-0a//fPscEXEwv+73Ja7jRf2eRWfF6VCsck9ZZ15zgog=";
      "rustls-0.19.1" = "sha256-zhE9NN1cLmWhRvw8i/9YYYOJp/1hgk+3LL7x4Pk6DC0=";
      "rustyline-8.0.0" = "sha256-FyMx2nAVaX0pc481BTlNxeR/NfNrr57FWKLS7+EjPVw=";
      "serde_str-1.0.0" = "sha256-CMBh5lxdQb2085y0jc/DrV6B8iiXvVO2aoZH/lFFjak=";
      "tokio-rustls-0.22.0" = "sha256-83ffBxKKJHnjFR73R50ka/10Mre43eoTx1eI2op53p8=";
      "warp-0.3.0" = "sha256-qImgS95fj57DJC0B/R8EV2z6ionHI1yV2OSkI9bq4bA=";
    };
  };

  nativeBuildInputs = [ makeWrapper pkg-config perl ];

  buildInputs = [
    curl
  ] ++ lib.optionals stdenv.isDarwin [ CoreServices Security libiconv xz ];

  checkFeatures = [ ];

  patches = [
    (substituteAll {
      src = ./0001-dynamically-patchelf-binaries.patch;
      inherit patchelf;
      dynamicLinker = stdenv.cc.bintools.dynamicLinker;
    })
  ];

  doCheck = false;

  meta = with lib; {
    description = "EdgeDB cli";
    homepage = "https://www.edgedb.com/docs/cli/index";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = [ maintainers.ranfdev ];
  };
}
