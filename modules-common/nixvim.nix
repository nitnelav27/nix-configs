{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # Set global options
      #expandtab = true;

    # Clipboard and theme
    clipboard = {
      providers = { wl-copy = { enable = true; }; };
      register = "unnamedplus";
    };

   colorschemes.nord.enable = true; 

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      #obsidian-nvim
      colorizer.enable = true;
      blink-cmp.enable = true;
      #catppuccin.enable = true;
      conform-nvim.enable = true;
      dressing.enable = true;
      flash.enable = true;
      friendly-snippets.enable = true;
      gitsigns.enable = true;
	### This requires future attention
      #mini-ai
      #mini-icons
      #mini-pairs
	### until here
      noice.enable = true;
      nui.enable = true;
      lint.enable = true;
      lspconfig.enable = true;
      ts-autotag.enable = true;
      #plenary-nvim
      snacks.enable = true;
      todo-comments.enable = true;
      trouble.enable = true;
      which-key.enable = true;
      vimtex.enable = true;
      cmp-vimtex.enable = true;
      notify.enable = true;
      treesitter.enable = true;
      dap-python.enable = true;
    };

    # Lua configuration
    extraConfigLua = ''
      require('dap-python').setup('python')
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

    # Plugin-specific configuration
    
    # LSP and language configuration
    lsp = {
      servers = {
        pyright = {
          enable = true;
          settings = { };
        };
        # Add other LSP servers as needed
      };
    };

    # Treesitter
    #treesitter = {
    #  enable = true;
    #  ensureInstalled = [ "python" "nix" "markdown" "html" "lua" "bash" "clang" ];
    #};

    # Formatters
    #formatters = {
    #  python = {
    #    enable = true;
    #    command = "black";
    #  };
    #  bash = { enable = true; };
    #  nix = { enable = true; };
    #  markdown = { enable = true; };
    #};

    # DAP (Debug Adapter Protocol)
    #dap = {
    #  enable = true;
    #  adapters = {
    #    python = {
    #      type = "executable";
    #      command = "python";
    #      args = [ "-m" "debugpy.adapter" ];
    #    };
    #  };
    #};

    # Add more configuration as needed
  };
}

