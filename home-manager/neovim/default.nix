{ config, lib, pkgs, nixvim, ... }: {
  programs.nixvim = {
    enable = true;

    plugins = {
      treesitter = {
        nixGrammars = true;
        ensureInstalled = "all";
        moduleConfig.autotag = {
          enable = true;
          filetypes =
            [ "html" "xml" "javascriptreact" "typescriptreact" "svelte" "vue" ];
        };
        nixvimInjections = true;
      };
    };
  };

  # Import all your configuration modules here
  imports = [
    nixvim.homeManagerModules.nixvim
    ./autopairs.nix
    ./cmp-nvim-lsp.nix
    ./colorscheme.nix
    ./comment-nvim.nix
    ./dadbod.nix
    ./dap.nix
    ./diffview.nix
    ./floaterm.nix
    ./gitsigns.nix
    #    ./nvim-ufo.nix
    ./harpoon.nix
    ./leap.nix
    ./lualine.nix
    ./mappings.nix
    ./neogit.nix
    ./nix.nix
    ./noice.nix
    ./null-ls.nix
    ./oil.nix
    ./options.nix
    ./surround.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./undotree.nix
    ./which-key.nix
    ./presence.nix
    ./toggleterm.nix
  ];
}
