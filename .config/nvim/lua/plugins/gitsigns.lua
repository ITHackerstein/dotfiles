return {
    "lewis6991/gitsigns.nvim",
    opts = {
        -- So it shown next to the diagnostics signs
        sign_priority = 100,
        on_attach = function(buffer)
            local gs = require("gitsigns")
            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = buffer })
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = buffer })

            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = buffer })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = buffer })

            vim.keymap.set("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { buffer = buffer })
        end
    }
}
