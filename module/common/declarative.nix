{config, lib,...}:

let
  inherit (lib) mkOption versionAtLeast;
  inherit (lib.types) bool lines;
in
{
  options = {
    declarative = mkOption {
      type = bool;
      description = "Whether using a declarative way to manage game files.";
      default = true;
    };
    allowedSymlinks.extraConfig = mkOption {
      type = lines;
      default = "";
      description = "Extra lines appneding to allowed_symlinks.txt.";
    };
  };
  config = {
    files = lib.mkIf (versionAtLeast config.version "1.20" && config.declarative) {
      "allowed_symlinks.txt".text = ''
        [prefix]/nix/store/
        ${config.allowedSymlinks.extraConfig}
      '';
    };
  };
}
