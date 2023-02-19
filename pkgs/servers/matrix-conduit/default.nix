{ lib, rustPlatform, fetchFromGitLab, stdenv, darwin, nixosTests, rocksdb_6_23 }:

rustPlatform.buildRustPackage rec {
  pname = "matrix-conduit";
  version = "0.5.0";

  src = fetchFromGitLab {
    owner = "famedly";
    repo = "conduit";
    rev = "v${version}";
    sha256 = "sha256-GSCpmn6XRbmnfH31R9c6QW3/pez9KHPjI99dR+ln0P4=";
  };

  # https://github.com/rust-lang/cargo/issues/11192
  # https://github.com/ruma/ruma/issues/1441
  postPatch = ''
    pushd $cargoDepsCopy
    patch -p0 < ${./cargo-11192-workaround.patch}
    for p in ruma*; do echo '{"files":{},"package":null}' > $p/.cargo-checksum.json; done
    popd
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "heed-0.10.6" = "sha256-rm02pJ6wGYN4SsAbp85jBVHDQ5ITjZZd+79EC2ubRsY=";
      "heed-traits-0.7.0" = "sha256-rm02pJ6wGYN4SsAbp85jBVHDQ5ITjZZd+79EC2ubRsY=";
      "heed-types-0.7.2" = "sha256-rm02pJ6wGYN4SsAbp85jBVHDQ5ITjZZd+79EC2ubRsY=";
      "reqwest-0.11.9" = "sha256-wH/q7REnkz30ENBIK5Rlxnc1F6vOyuEANMHFmiVPaGw=";
      "ruma-0.7.4" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-appservice-api-0.7.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-client-api-0.15.3" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-common-0.10.5" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-federation-api-0.6.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-identifiers-validation-0.9.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-identity-service-api-0.6.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-macros-0.10.5" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-push-gateway-api-0.6.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-signatures-0.12.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
      "ruma-state-res-0.8.0" = "sha256-ztobLdOXSGyK1YcPMMIycO3ZmnjxG5mLkHltf0Fbs8s=";
    };
  };

  nativeBuildInputs = [
    rustPlatform.bindgenHook
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  ROCKSDB_INCLUDE_DIR = "${rocksdb_6_23}/include";
  ROCKSDB_LIB_DIR = "${rocksdb_6_23}/lib";

  # tests failed on x86_64-darwin with SIGILL: illegal instruction
  doCheck = !(stdenv.isx86_64 && stdenv.isDarwin);

  passthru.tests = {
    inherit (nixosTests) matrix-conduit;
  };

  meta = with lib; {
    description = "A Matrix homeserver written in Rust";
    homepage = "https://conduit.rs/";
    license = licenses.asl20;
    maintainers = with maintainers; [ pstn piegames pimeys ];
    mainProgram = "conduit";
  };
}
