require("lazy").setup(
{
   {
    "nvim-neorg/neorg",
    ft = "norg",
    dev = true;
   }
},

  {
	dev = {
		path = vim.g.nix_plugins_dir,
		patterns = {
			".",
		},
	},
})
