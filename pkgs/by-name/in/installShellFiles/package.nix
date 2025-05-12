{
  lib,
  callPackage,
  makeSetupHook,
  stdenv,
  buildPackages,
}:

# See the header comment in ./setup-hook.sh for example usage.
makeSetupHook {
  name = "install-shell-files";
  passthru = {
    mkInstallCompletionSnippet =
      {
        bash ? true,
        zsh ? true,
        fish ? true,
        buildPackagesSelf,
        installer,
        __execDirectly ? stdenv.buildPlatform.canExecute stdenv.hostPlatform,
      }:
      let
        copySnippet = shellName: outDir: ''
          echo "copying ${shellName} completions from ${lib.getBin buildPackagesSelf}"
          mkdir -p "$shareDir/${builtins.dirOf outDir}"
          cp -rv "${lib.getBin buildPackagesSelf}/share/${outDir}" "$shareDir/${builtins.dirOf outDir}"
        '';
      in
      if __execDirectly then
        installer (stdenv.hostPlatform.emulator buildPackages)
      else
        ''
          local shareDir="''${!outputBin:?}/share"
        ''
        + lib.optionalString bash (copySnippet "bash" "bash-completion/completions")
        + lib.optionalString zsh (copySnippet "zsh" "zsh/site-functions")
        + lib.optionalString fish (copySnippet "fish" "fish/vendor_completions.d");

    tests = lib.packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ./tests;
    };
  };
} ./setup-hook.sh
