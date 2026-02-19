{
    programs.nixvim = {
        colorschemes.gruvbox.enable = true;
        opts = {
            signcolumn = "yes:2";
            cursorline = true;
            number = true;
            relativenumber = true;
            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            splitright = true;
            splitbelow = true;
            winborder = "rounded";
            undofile = true;
            swapfile = false;
            autoread = true;
            conceallevel = 2;
            concealcursor = "nc";
        };
        globals = {
            mapleader = " ";
            maplocalleader = "\\";
        };
        autoCmd = [
            { # Automatically reload files
                event = [ "BufEnter" "CursorHold" "CursorHoldI" "FocusGained" ];
                pattern = "*";
                command = "if mode() != 'c' | checktime | endif";
            }
            { # Automatically remove trailing whitespaces
                event = [ "BufWritePre" ];
                pattern = "*";
                callback.__raw = ''
                    function()
                        local cursor_pos = vim.fn.getpos(".")
                        vim.cmd[[%s/\s\+$//e]]
                        vim.fn.setpos(".", cursor_pos)
                    end
                '';
            }
        ];
        clipboard.register = "unnamedplus";
        extraConfigLua = ''
            vim.cmd[[filetype indent off]];
            vim.cmd[[filetype plugin on]];
            vim.cmd[[hi! link texMathEnvArgName texEnvArgName]]
            vim.cmd[[hi! link texMathZone LocalIdent]]
            vim.cmd[[hi! link texMathZoneEnv texMathZone]]
            vim.cmd[[hi! link texMathZoneEnvStarred texMathZone]]
            vim.cmd[[hi! link texMathZoneX texMathZone]]
            vim.cmd[[hi! link texMathZoneXX texMathZone]]
            vim.cmd[[hi! link texMathZoneEnsured texMathZone]]
            vim.cmd[[hi! link Conceal LocalIdent]]

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN]  = "",
                        [vim.diagnostic.severity.INFO]  = "",
                        [vim.diagnostic.severity.HINT]  = "󰌵",
                    }
                }
            })
        '';
    };
}
