{
    programs.nixvim.plugins = {
        friendly-snippets.enable = true;
        blink-cmp-copilot.enable = true;
        blink-cmp = {
            enable = true;
            settings = {
                keymap = {
                    preset = "none";
                    "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
                    "<C-e>" = [ "hide" "fallback" ];
                    "<C-y>" = [ "select_and_accept" "fallback" ];
                    "<C-p>" = [ "select_prev" "fallback_to_mappings" ];
                    "<C-n>" = [ "select_next" "fallback_to_mappings" ];
                    "<C-b>" = [ "scroll_documentation_up" "fallback" ];
                    "<C-f>" = [ "scroll_documentation_down" "fallback" ];
                    "<C-k>" = [ "snippet_forward" "fallback" ];
                    "<C-j>" = [ "snippet_backward" "fallback" ];
                    "<C-s>" = [ "show_signature" "hide_signature" "fallback" ];
                };
                completion.documentation.auto_show = false;
                signature.enabled = true;
                sources = {
                    default = [ "lsp" "path" "snippets" "buffer" "copilot" ];
                    providers.copilot = {
                        name = "copilot";
                        module = "blink-cmp-copilot";
                        score_offset = 100;
                        async = true;
                    };
                };
            };
        };
    };
}
