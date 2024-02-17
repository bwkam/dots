local options = {
  backup = false,                         -- creates a backup file
  clipboard = "unnamedplus",              -- allows neovim to access the system clipboard
  -- cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                       -- so that `` is visible in markdown files
  fileencoding = "utf-8",                 -- the encoding written to a file
  hlsearch = true,                        -- highlight all matches on previous search pattern
  ignorecase = true,                      -- ignore case in search patterns
  mouse = "a",                            -- allow the mouse to be used in neovim
  pumheight = 10,                         -- pop up menu height
  showmode = false,                       -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                        -- always show tabs
  smartcase = true,                       -- smart case
  smartindent = true,                     -- make indenting smarter again
  splitbelow = true,                      -- force all horizontal splits to go below current window
  splitright = true,                      -- force all vertical splits to go to the right of current window
  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                        -- enable persistent undo
  updatetime = 300,                       -- faster completion (4000ms default)
  writebackup = false,                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                       -- convert tabs to spaces
  shiftwidth = 2,                         -- the number of spaces inserted for each indentation
  tabstop = 2,                            -- insert 2 spaces for a tab
  cursorline = true,                      -- highlight the current line
  number = true,                          -- set numbered lines
  relativenumber = false,                 -- set relative numbered lines
  numberwidth = 4,                        -- set number column width to 2 {default 4}
  wildmenu = false,                       -- don't use the wildmenu

  signcolumn = "yes",                     -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                            -- display lines as one long line
  linebreak = true,                       -- companion to wrap, don't split words
  -- guicursor = { "a:ver25" },
  scrolloff = 8,                          -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                      -- minimal number of screen columns either side of cursor if wrap is `false`
  guifont = "Iosevka:h9",                 -- the font used in graphical neovim applications
  whichwrap = "bs<>[]hl",                 -- which "horizontal" keys are allowed to travel to prev/next line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- neovide specific options
-- vim.g.neovide_scale_factor = 0.7

-- vimtex
vim.g.vimtex_view_method = "zathura"

function Sad(line_nr, from, to, fname)
  vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname))
end

function IncreasePadding()
  Sad("07", 0, 20, "$HOME/.config/alacritty/alacritty.yml")
  Sad("08", 0, 20, "$HOME/.config/alacritty/alacritty.yml")
end

function DecreasePadding()
  Sad("07", 20, 0, "~/dotfiles/alacritty/alacritty.windows.yml")
  Sad("08", 20, 0, "~/dotfiles/alacritty/alacritty.windows.yml")
end

vim.cmd([[
  augroup ChangeAlacrittyPadding
   au!
   au VimEnter * lua DecreasePadding()
   au VimLeavePre * lua IncreasePadding()
  augroup END
]])

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append("c")                   -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-")                   -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
