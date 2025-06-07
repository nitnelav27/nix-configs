{ config, pkgs, lib, inputs, ... }: 
{
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "nord";
          style = "darker";
        };
        startPlugins = [
          "obsidian-nvim"
          "nvim-colorizer-lua"
          "blink-cmp"
          "catppuccin"
          "conform-nvim"
          "flash-nvim"
          "friendly-snippets"
          "gitsigns-nvim"
          "mini-ai"
          "mini-icons"
          "mini-pairs"
          "noice-nvim"
          "nui-nvim"
          "nvim-lint"
          "nvim-lspconfig"
          "nvim-ts-autotag"
          "plenary-nvim"
          "snacks-nvim"
          "todo-comments-nvim"
          "trouble"
          "which-key-nvim"
          pkgs.vimPlugins.vimtex
          pkgs.vimPlugins.cmp-vimtex
        ];
        luaConfigPost = ''
          vim.g.vimtex_view_method = 'zathura'
          vim.g.vimtex_compiler_latexmk = {
            executable = 'latexmk',
            options = {
            '-xelatex',
            '-verbose',
            '-file-line-error',
            '-synctex=1',
            '-interaction=nonstopmode',
            }
          }
        '';
        ui = {
          noice.enable = true;
          colorizer = {
            enable = true;
            setupOpts = {
              filetypes = {
                "*" = {
                  AARRGGBB = true;
                  RGB = true;
                  RRGGBB = true;
                  RRGGBBAA = true;
                  always_update = true;
                  css = true;
                  mode = "background";
                  names = true;
                };
              };
            };
          };
          breadcrumbs.enable = true;
          illuminate.enable = true;
          smartcolumn.enable = true;
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        options = {
          relativenumber = false;
          cursorline = true;
        };
        lsp.enable = true;
        languages = {
          enableTreesitter = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
          };
          python = {
            enable = true;
            dap.enable = true;
            format.enable = true;
            lsp.enable = true;
          };
          markdown.enable = true;
          clang.enable = true;
          html.enable = true;
          lua.enable = true;
                                        #tex = {
                                        #enable = true;
                                        #lsp = {
                                        #enable = true;
                                        #package = pkgs.texlab;
                                        #};
                                        #};
        };
      };
    };
  };
}
