{ stdenv
, lib
, rustPlatform
, fetchFromGitHub
, Security
, DiskArbitration
, Foundation
, nixosTests
}:

let version = "1.0.0";
in
rustPlatform.buildRustPackage {
  pname = "meilisearch";
  inherit version;

  src = fetchFromGitHub {
    owner = "meilisearch";
    repo = "MeiliSearch";
    rev = "v${version}";
    hash = "sha256-XWPJldWxe8iply7XtmDem1gfbNuuaWuFdMfuCbcU6tc=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "actix-web-static-files-3.0.5" = "sha256-2BN0RzLhdykvN3ceRLkaKwSZtel2DBqZ+uz4Qut+nII=";
      "filter-parser-0.41.1" = "sha256-CEGDqqxQUa5FcQezfF+3HsJ2FrofDLy6Ud66yknQaoA=";
      "flatten-serde-json-0.41.1" = "sha256-CEGDqqxQUa5FcQezfF+3HsJ2FrofDLy6Ud66yknQaoA=";
      "heed-0.12.4" = "sha256-kKwpr5zuTKUkl12J8KgXrlQiK4ee+D5xNq0DF1yWGsQ=";
      "heed-traits-0.7.0" = "sha256-kKwpr5zuTKUkl12J8KgXrlQiK4ee+D5xNq0DF1yWGsQ=";
      "heed-types-0.7.2" = "sha256-kKwpr5zuTKUkl12J8KgXrlQiK4ee+D5xNq0DF1yWGsQ=";
      "json-depth-checker-0.41.1" = "sha256-CEGDqqxQUa5FcQezfF+3HsJ2FrofDLy6Ud66yknQaoA=";
      "lmdb-rkv-sys-0.15.1" = "sha256-qT8b4F4bgH6mVhXzwbpv2IBgeHS2U1lr7n5t4gpwGIg=";
      "milli-0.41.1" = "sha256-CEGDqqxQUa5FcQezfF+3HsJ2FrofDLy6Ud66yknQaoA=";
      "nelson-0.1.0" = "sha256-eF672quU576wmZSisk7oDR7QiDafuKlSg0BTQkXnzqY=";
    };
  };

  # Default features include mini dashboard which downloads something from the internet.
  buildNoDefaultFeatures = true;

  buildInputs = lib.optionals stdenv.isDarwin [
    Security
    DiskArbitration
    Foundation
  ];

  passthru.tests = {
    meilisearch = nixosTests.meilisearch;
  };

  # Tests will try to compile with mini-dashboard features which downloads something from the internet.
  doCheck = false;

  meta = with lib; {
    description = "Powerful, fast, and an easy to use search engine ";
    homepage = "https://docs.meilisearch.com/";
    changelog = "https://github.com/meilisearch/meilisearch/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ happysalada ];
    platforms = [ "aarch64-darwin" "x86_64-linux" "x86_64-darwin" ];
  };
}
