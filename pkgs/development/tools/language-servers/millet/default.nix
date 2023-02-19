{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "millet";
  version = "0.7.7";

  src = fetchFromGitHub {
    owner = "azdavis";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1GoZbeXNG00oxBdPa2yk0aOCVguwIkK6fKrlHU6mZYc=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "char-name-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "code-h2-md-map-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "diagnostic-util-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "elapsed-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "event-parse-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "fast-hash-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "fmt-util-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "identifier-case-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "idx-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "paths-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "pattern-match-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "rowan-0.15.10" = "sha256-yOaUq2tQEiNgQB7qB8fFzfnwUWagu72MIPHmaTX0B0Y=";
      "sml-libs-0.1.0" = "sha256-6jbRMqlW5sL0x0i4qatduXvLHhrkUE7gsSwC6JYwiHQ=";
      "str-util-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "syntax-gen-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "text-pos-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "text-size-util-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "token-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "topo-sort-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
      "uniq-0.1.0" = "sha256-mQU6kmVizJJTb3JF61YWUVZqSeGSs6PluCF32y/uov8=";
    };
  };

  postPatch = ''
    rm .cargo/config.toml
  '';

  cargoBuildFlags = [ "--package" "millet-ls" ];

  cargoTestFlags = [ "--package" "millet-ls" ];

  meta = with lib; {
    description = "A language server for Standard ML";
    homepage = "https://github.com/azdavis/millet";
    changelog = "https://github.com/azdavis/millet/raw/v${version}/docs/changelog.md";
    license = [ licenses.mit /* or */ licenses.asl20 ];
    maintainers = with maintainers; [ marsam ];
    mainProgram = "millet-ls";
  };
}
