{ clang
, cmake
, fetchFromGitHub
, fetchurl
, lib
, lighthouse
, llvmPackages
, nodePackages
, perl
, protobuf
, rustPlatform
, Security
, CoreFoundation
, stdenv
, testers
, unzip
, nix-update-script
, SystemConfiguration
}:

rustPlatform.buildRustPackage rec {
  pname = "lighthouse";
  version = "3.4.0";

  # lighthouse/common/deposit_contract/build.rs
  depositContractSpecVersion = "0.12.1";
  testnetDepositContractSpecVersion = "0.9.2.1";

  src = fetchFromGitHub {
    owner = "sigp";
    repo = "lighthouse";
    rev = "v${version}";
    hash = "sha256-4auiM5+kj/HjZKu2YP7JEnwDNxHuL39XCfmV/dc5jLE=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "amcl-0.3.0" = "sha256-QoqDj3OZdf4ENPE9ACBC9A/STqCku6sZIt3AMLtpjC4=";
      "beacon-api-client-0.1.0" = "sha256-HXRc8Pw3+4xSj5sDoqdfGR2NNtYC7kz8v6uel9rwJHI=";
      "ethereum-consensus-0.1.1" = "sha256-LqkLW6L8SH5H2Ua6GQWhGt9W4JoGSYEpqhDLdVifceU=";
      "fixed-hash-0.7.0" = "sha256-osShTWl9y9dsXlGWLkL10OqFsf3Ug9+cf08HW7oC7/A=";
      "libmdbx-0.1.4" = "sha256-NMsR/Wl1JIj+YFPyeMMkrJFfoS07iEAKEQawO89a+/Q=";
      "lmdb-rkv-0.14.0" = "sha256-RkeSnaJwoGnO1IXRM0pMdO6fYFoDWDPQF/4IK7/SFB0=";
      "lmdb-rkv-sys-0.11.2" = "sha256-RkeSnaJwoGnO1IXRM0pMdO6fYFoDWDPQF/4IK7/SFB0=";
      "mdbx-sys-0.11.6-4" = "sha256-NMsR/Wl1JIj+YFPyeMMkrJFfoS07iEAKEQawO89a+/Q=";
      "mev-build-rs-0.2.1" = "sha256-rXwZVaQmAb5Oxn5NFELaxqfovGUGWfzDm5oL46Mt3Cg=";
      "milagro_bls-1.4.2" = "sha256-QoqDj3OZdf4ENPE9ACBC9A/STqCku6sZIt3AMLtpjC4=";
      "ssz-rs-0.8.0" = "sha256-CgX34M1fL6Xn/ZtgHPfNeiv9xsf44jM5jZOmV+0EnE0=";
      "ssz-rs-derive-0.8.0" = "sha256-CgX34M1fL6Xn/ZtgHPfNeiv9xsf44jM5jZOmV+0EnE0=";
      "warp-0.3.2" = "sha256-m9lkEgeSs0yEc+6N6DG7IfQY/evkUMoNyst2hMUR//c=";
    };
  };

  buildFeatures = [ "modern" "gnosis" ];

  nativeBuildInputs = [ rustPlatform.bindgenHook cmake perl protobuf ];

  buildInputs = lib.optionals stdenv.isDarwin [
    Security
  ] ++ lib.optionals (stdenv.isDarwin && stdenv.isx86_64) [
    CoreFoundation SystemConfiguration
  ];

  depositContractSpec = fetchurl {
    url = "https://raw.githubusercontent.com/ethereum/eth2.0-specs/v${depositContractSpecVersion}/deposit_contract/contracts/validator_registration.json";
    hash = "sha256-ZslAe1wkmkg8Tua/AmmEfBmjqMVcGIiYHwi+WssEwa8=";
  };

  testnetDepositContractSpec = fetchurl {
    url = "https://raw.githubusercontent.com/sigp/unsafe-eth2-deposit-contract/v${testnetDepositContractSpecVersion}/unsafe_validator_registration.json";
    hash = "sha256-aeTeHRT3QtxBRSNMCITIWmx89vGtox2OzSff8vZ+RYY=";
  };

  LIGHTHOUSE_DEPOSIT_CONTRACT_SPEC_URL = "file://${depositContractSpec}";
  LIGHTHOUSE_DEPOSIT_CONTRACT_TESTNET_URL = "file://${testnetDepositContractSpec}";

  cargoBuildFlags = [
    "--package lighthouse"
  ];

  __darwinAllowLocalNetworking = true;

  checkFeatures = [ ];

  # All of these tests require network access
  cargoTestFlags = [
    "--workspace"
    "--exclude beacon_node"
    "--exclude http_api"
    "--exclude beacon_chain"
    "--exclude lighthouse"
    "--exclude lighthouse_network"
    "--exclude slashing_protection"
    "--exclude web3signer_tests"
  ];

  # All of these tests require network access
  checkFlags = [
    "--skip service::tests::tests::test_dht_persistence"
    "--skip time::test::test_reinsertion_updates_timeout"
  ] ++ lib.optionals (stdenv.isAarch64 && stdenv.isDarwin) [
    "--skip subnet_service::tests::sync_committee_service::same_subscription_with_lower_until_epoch"
    "--skip subnet_service::tests::sync_committee_service::subscribe_and_unsubscribe"
  ];

  nativeCheckInputs = [
    nodePackages.ganache
  ];

  passthru = {
    tests.version = testers.testVersion {
      package = lighthouse;
      command = "lighthouse --version";
      version = "v${lighthouse.version}";
    };
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "Ethereum consensus client in Rust";
    homepage = "https://lighthouse.sigmaprime.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [ centromere pmw ];
  };
}
