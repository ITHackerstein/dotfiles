{
    programs.nixvim.plugins = {
        lsp = {
            enable = true;
            servers = {
                clangd.enable = true;
                tinymist.enable = true;
            };
            onAttach = ''
                local telescope_builtin = require("telescope.builtin")
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references, opts)
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)

                vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)

                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

                if client.name == "clangd" then
                    vim.keymap.set("n", "<leader>cs", ":LspClangdSwitchSourceHeader<CR>", opts)
                end
            '';
        };
    };
}
