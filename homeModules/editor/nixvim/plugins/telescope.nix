{
    programs.nixvim.plugins.telescope = {
        enable = true;
        keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
        };
        extensions = {
            fzf-native.enable = true;
            ui-select.enable = true;
        };
    };
}
