{ config, lib, pkgs, ... }:
let
    cfg = config.custom.fonts;
in
{
    options.custom.fonts = {
        enable = lib.mkEnableOption "enable fonts setup";
        enableWinFonts = lib.mkEnableOption "enable Windows fonts";
    };

    config = lib.mkIf cfg.enable {
        fonts.fontconfig.enable = true;
        home.packages = lib.mkIf cfg.enableWinFonts [
            pkgs.corefonts
            pkgs.vista-fonts
        ];
    };
}
