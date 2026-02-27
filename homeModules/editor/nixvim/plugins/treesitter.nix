{ pkgs, ... }:
{
    programs.nixvim.plugins = {
        treesitter = {
            enable = true;
            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                bash
                c
                cmake
                cpp
                css
                diff
                gitcommit
                html
                java
                javadoc
                javascript
                json
                lua
                luadoc
                make
                markdown
                markdown_inline
                php
                php_only
                python
                sql
                toml
                typst
                vim
                vimdoc
                yaml
            ];
            settings.highlight.enable = true;
        };
        treesitter-textobjects.enable = true;
    };
}
