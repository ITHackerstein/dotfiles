{ config, lib, ... }:
let
    cfg = config.custom.amdgpu;
in
{
    options.custom.amdgpu = {
        enable = lib.mkEnableOption "enable AMDGPU";
    };

    config = lib.mkIf cfg.enable {
        hardware.amdgpu.opencl.enable = true;
    };
}
