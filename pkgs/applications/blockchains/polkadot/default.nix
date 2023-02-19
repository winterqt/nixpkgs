{ clang
, fetchFromGitHub
, lib
, llvmPackages
, protobuf
, rocksdb
, rustPlatform
, stdenv
, writeShellScriptBin
, Security
, SystemConfiguration
}:
rustPlatform.buildRustPackage rec {
  pname = "polkadot";
  version = "0.9.37";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot";
    rev = "v${version}";
    hash = "sha256-/mgJNjliPUmMkhT/1oiX9+BJHfY3SMsKfFv9HCyWRQQ=";

    # the build process of polkadot requires a .git folder in order to determine
    # the git commit hash that is being built and add it to the version string.
    # since having a .git folder introduces reproducibility issues to the nix
    # build, we check the git commit hash after fetching the source and save it
    # into a .git_commit file, and then delete the .git folder. we can then use
    # this file to populate an environment variable with the commit hash, which
    # is picked up by polkadot's build process.
    leaveDotGit = true;
    postFetch = ''
      ( cd $out; git rev-parse --short HEAD > .git_commit )
      rm -rf $out/.git
    '';
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "beefy-gadget-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "beefy-gadget-rpc-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "beefy-merkle-tree-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "fork-tree-3.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-benchmarking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-benchmarking-cli-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-election-provider-solution-type-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-election-provider-support-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-executive-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-remote-externalities-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-procedural-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-procedural-tools-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-procedural-tools-derive-3.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-test-3.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-support-test-pallet-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-system-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-system-benchmarking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-system-rpc-runtime-api-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "frame-try-runtime-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "generate-bags-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "mmr-gadget-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "mmr-rpc-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-assets-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-authority-discovery-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-authorship-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-babe-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-bags-list-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-bags-list-remote-tests-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-balances-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-beefy-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-beefy-mmr-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-bounties-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-child-bounties-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-collective-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-conviction-voting-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-democracy-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-election-provider-multi-phase-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-election-provider-support-benchmarking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-elections-phragmen-5.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-fast-unstake-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-grandpa-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-identity-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-im-online-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-indices-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-membership-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-mmr-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-multisig-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-nis-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-nomination-pools-1.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-nomination-pools-benchmarking-1.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-nomination-pools-runtime-api-1.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-offences-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-offences-benchmarking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-preimage-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-proxy-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-ranked-collective-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-recovery-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-referenda-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-scheduler-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-session-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-session-benchmarking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-society-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-staking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-staking-reward-curve-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-staking-reward-fn-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-state-trie-migration-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-sudo-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-timestamp-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-tips-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-transaction-payment-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-transaction-payment-rpc-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-transaction-payment-rpc-runtime-api-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-treasury-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-utility-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-vesting-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "pallet-whitelist-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-allocator-4.1.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-authority-discovery-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-basic-authorship-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-block-builder-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-chain-spec-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-chain-spec-derive-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-cli-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-client-api-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-client-db-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-consensus-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-consensus-babe-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-consensus-babe-rpc-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-consensus-epochs-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-consensus-slots-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-executor-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-executor-common-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-executor-wasmi-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-executor-wasmtime-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-finality-grandpa-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-finality-grandpa-rpc-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-informant-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-keystore-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-bitswap-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-common-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-gossip-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-light-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-sync-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-network-transactions-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-offchain-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-peerset-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-proposer-metrics-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-rpc-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-rpc-api-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-rpc-server-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-rpc-spec-v2-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-service-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-state-db-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-sync-state-rpc-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-sysinfo-6.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-telemetry-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-tracing-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-tracing-proc-macro-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-transaction-pool-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-transaction-pool-api-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sc-utils-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-api-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-api-proc-macro-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-application-crypto-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-arithmetic-6.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-authority-discovery-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-authorship-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-beefy-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-block-builder-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-blockchain-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-consensus-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-consensus-babe-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-consensus-slots-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-consensus-vrf-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-core-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-core-hashing-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-core-hashing-proc-macro-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-database-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-debug-derive-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-externalities-0.13.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-finality-grandpa-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-inherents-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-io-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-keyring-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-keystore-0.13.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-maybe-compressed-blob-4.1.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-mmr-primitives-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-npos-elections-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-offchain-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-panic-handler-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-rpc-6.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-runtime-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-runtime-interface-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-runtime-interface-proc-macro-6.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-session-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-staking-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-state-machine-0.13.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-std-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-storage-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-timestamp-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-tracing-6.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-transaction-pool-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-transaction-storage-proof-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-trie-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-version-5.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-version-proc-macro-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-wasm-interface-7.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sp-weights-4.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "sub-tokens-0.1.0" = "sha256-GvhgZhOIX39zF+TbQWtTCgahDec4lQjH+NqamLFLUxM=";
      "substrate-build-script-utils-3.0.0" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-frame-rpc-system-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-prometheus-endpoint-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-rpc-client-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-state-trie-migration-rpc-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-test-client-2.0.1" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-test-utils-4.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-test-utils-derive-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "substrate-wasm-builder-5.0.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
      "try-runtime-cli-0.10.0-dev" = "sha256-MUUH5v6CKuzDBIXYlJLDFVz6WfaVllzxO9afvWeUZXY=";
    };
  };

  buildInputs = lib.optionals stdenv.isDarwin [ Security SystemConfiguration ];

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  preBuild = ''
    export SUBSTRATE_CLI_GIT_COMMIT_HASH=$(cat .git_commit)
    rm .git_commit
  '';

  PROTOC = "${protobuf}/bin/protoc";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";

  # NOTE: We don't build the WASM runtimes since this would require a more
  # complicated rust environment setup and this is only needed for developer
  # environments. The resulting binary is useful for end-users of live networks
  # since those just use the WASM blob from the network chainspec.
  SKIP_WASM_BUILD = 1;

  # We can't run the test suite since we didn't compile the WASM runtimes.
  doCheck = false;

  meta = with lib; {
    description = "Polkadot Node Implementation";
    homepage = "https://polkadot.network";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ akru andresilva asymmetric FlorianFranzen RaghavSood ];
    platforms = platforms.unix;
  };
}
