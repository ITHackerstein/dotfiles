{
    programs.nixvim.plugins.todo-comments = {
        enable = true;
        settings.signs = false;
    };

    programs.nixvim.keymaps = [
        {
            key = "<leader>ft";
            action = "<cmd>:TodoTelescope<CR>";
            options = {
                silent = true;
                desc = "Find TODOs";
            };
        }
    ];
}
