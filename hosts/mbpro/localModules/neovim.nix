{ config, pkgs, self, lib, inputs, ... }: 
{
    programs.nvf = {
        enable = true;
        enableManpages = true;
        settings = {
            vim = {
                globals = {
                    mapleader = " ";
                };
                clipboard = {
                    enable = true;
                    providers.wl-copy.enable = true;
                    registers = "unnamedplus";
                };
                theme = {
                    enable = true;
                    name = "nord";
                    style = "darker";
                };
                extraPlugins = with pkgs.vimPlugins; {
                    nvim-autopairs = {
                        package = nvim-autopairs;
                        setup = ''require("nvim-autopairs").setup {}'';
                    };
                };
                startPlugins = [
                    "obsidian-nvim"
                    "nvim-colorizer-lua"
                    "blink-cmp"
                    "catppuccin"
                    "conform-nvim"
                    "dressing-nvim"
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
                    pkgs.vimPlugins.nvim-notify
                    pkgs.vimPlugins.nvim-treesitter
                    pkgs.vimPlugins.nvim-dap-python
                    pkgs.vimPlugins.conform-nvim
                    pkgs.vimPlugins.nvim-lint
                    pkgs.vimPlugins.trouble-nvim
                ];
                luaConfigPost = ''
                    -- Configure Python DAP
                    require('dap-python').setup('python')
                    -- VIM options
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
                pluginRC = {
                    nvim-notify = ''
                        require("notify").setup({
                        background_colour = "#000000",
                        stages = "fade_in_slide_out"
                        })
                    '';
                    noice-nvim = ''
                        local noice = require("noice")
                        noice.setup({
                        lsp = {
                            progress = { enables = true },
                            override = {
                                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                                ["vim.lsp.util.stylize_markdown"] = true,
                                ["cmp.entry.get_documentation"] = true,
                            },
                        },
                        presets = {
                            bottom_search = true,
                            command_palette = true,
                            long_message_to_split = true,
                        },
                        views = {
                            cmdline_popup = {
                                position = {
                                    row = "40%",
                                    col = "50%",
                                },
                                size = {
                                    width = 60,
                                    height = "auto",
                                },
                            },
                            popupmenu = {
                                relative = "editor",
                                position = {
                                    row = 8,
                                    col = "50%",
                                },
                                size = {
                                    width = 60,
                                    height = 10,
                                },
                                border = {
                                    style = "rounded",
                                    padding = { 0,1 },
                                },
                                win_options = {
                                    winhighlight = {
                                        Normal = "Normal",
                                        FloatBorder = "DiagnosticInfo",
                                    },
                                },
                            },
                        },
                        routes = {
                            {
                                view = "notify",
                                filter = { event = "msg_showmode" },
                            },
                            {
                                filter = {
                                    event = "lsp",
                                    kind = "progress",
                                    cond = function(message)
                                        local client = vim.tbl_get(message.opts, "progress", "client")
                                        return client == "lua_ls" or client == "null-ls"
                                    end,
                                },
                                opts = { skip = true },
                            },
                        },
                        })
                    '';
                };
                autocomplete.nvim-cmp = {
                    enable = true;
                    sources = lib.mkForce {
                        "nvim_lsp" = "[LSP]";
                        "path" = "[Path]";
                        "buffer" = "[Buffer]";
                        "luasnip" = "[snippets]";
                    };
                };
                utility = {
                    preview = {
                        glow.enable = true;
                        glow.mappings.openPreview = "<leader>mg";
                        markdownPreview = {
                            enable = true;
                            alwaysAllowPreview = true;
                            autoClose = true;
                            autoStart = true;
                        };
                    };
                    snacks-nvim.enable = true;
                    images = {
                        image-nvim = {
                            enable = true;
                            setupOpts = {
                                backend = "kitty";
                                editorOnlyRenderWhenFocused = false;
                                integrations = {
                                    markdown = {
                                        enable = true;
                                        clearInInsertMode = true;
                                        downloadRemoteImages = true;
                                    };
                                };
                            };
                        };
                        img-clip.enable = true;
                    };
                };
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
                fzf-lua.enable = true;
                filetree = {
                    neo-tree.enable = true;
                };
                options = {
                    relativenumber = false;
                    cursorline = true;
                    tabstop = 4;
                    softtabstop = 4;
                    showtabline = 4;
                    expandtab = true;
                    smartindent = true;
                    shiftwidth = 4;
                    breakindent = true;
                };
                lsp = {
                    enable = true;
                    trouble = {
                        enable = true;
                    };
                };
                languages = {
                    enableFormat = true;
                    enableDAP = true;
                    enableExtraDiagnostics = true;
                    enableTreesitter = true;
                    astro = {
                      enable = false;
                      format = {
                        package = pkgs.nodePackages.prettier;
                      };
                    };
                    bash = {
                        enable = true;
                        format.enable = true;
                        lsp.enable = true;
                    };
                    nix = {
                        enable = true;
                        format.enable = true;
                        lsp.enable = true;
                    };
                    python = {
                        enable = true;
                        dap.enable = true;
                        format.enable = true;
                        format.type = "black";
                        lsp.enable = true;
                        lsp.server = "pyright";
                    };
                    markdown = {
                        enable = true;
                        format.enable = true;
                        lsp.enable = true;
                        extensions = {
                            markview-nvim.enable = true;
                            render-markdown-nvim.enable = true;
                        };
                    };
                    clang.enable = true;
                    html = {
                        enable = true;
                        treesitter.autotagHtml = true;
                    };
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
