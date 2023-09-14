{ pkgs, ... }:

{
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
  };
  maps = {
    normal = {
      "<leader>f" = {
        desc = "  Find";
      };
      "<leader>ff" = {
        desc = "Find Files";
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        silent = true;
      };
      "<leader>fg" = {
        desc = "Grep Files";
        action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
        silent = true;
      };
      "<leader>fb" = {
        desc = "Find Buffer";
        action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
        silent = true;
      };
      "<leader>fh" = {
        desc = "Find Help";
        action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
        silent = true;
      };
      "<leader>fd" = {
        desc = "Find Diagnostics";
        action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
        silent = true;
      };
      "<leader>ft" = {
        desc = "Find Treesitter";
        action = "<cmd>lua require('telescope.builtin').treesitter()<CR>";
        silent = true;
    };
    };
  };
  extraPackages = with pkgs; [ fzf ];
}

