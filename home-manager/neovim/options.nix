{
  config = {
    globals.mapleader = " ";
    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };
    options = {
      relativenumber = true; # Show relative line numbers
      number = true; # Show line numbers
      undofile = true; # Automatically save and restore undo history
      signcolumn = "yes"; # Whether to show the signcolumn
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|

      # Tab options
      tabstop =
        4; # Number of spaces a <Tab> in the text stands for (local to buffer)
      shiftwidth =
        4; # Number of spaces used for each step of (auto)indent (local to buffer)
      softtabstop =
        0; # If non-zero, number of spaces to insert for a <Tab> (local to buffer)
      expandtab =
        true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      autoindent = true; # Do clever autoindenting
    };
  };
}
