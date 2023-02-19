{ lib
, rustPlatform
, fetchFromGitHub
, protobuf
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "qdrant";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "qdrant";
    repo = "qdrant";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-MT2k4k/g97iXVUCz1dYJdL+JBCLKTWqE2u2Yiuvd/nw=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "raft-0.7.0" = "sha256-UVP96T0BBQMWEjHcBH+hZQWiksgA3+7RUQObmSHvJJg=";
      "raft-proto-0.7.0" = "sha256-UVP96T0BBQMWEjHcBH+hZQWiksgA3+7RUQObmSHvJJg=";
      "wal-0.1.2" = "sha256-dJGWs3iSE3ZCPCG9OxVkfjQhbdoAA3dVIkGhecRpCd0=";
    };
  };

  prePatch = lib.optionalString stdenv.isAarch64 ''
    substituteInPlace .cargo/config.toml \
      --replace "[target.aarch64-unknown-linux-gnu]" "" \
      --replace "linker = \"aarch64-linux-gnu-gcc\"" ""
  '';

  nativeBuildInputs = [ protobuf rustPlatform.bindgenHook ];

  NIX_CFLAGS_COMPILE = lib.optional stdenv.isDarwin "-faligned-allocation";

  meta = with lib; {
    description = "Vector Search Engine for the next generation of AI applications";
    longDescription = ''
      Expects a config file at config/config.yaml with content similar to
      https://github.com/qdrant/qdrant/blob/master/config/config.yaml
    '';
    homepage = "https://github.com/qdrant/qdrant";
    license = licenses.asl20;
    maintainers = with maintainers; [ dit7ya ];
  };
}
