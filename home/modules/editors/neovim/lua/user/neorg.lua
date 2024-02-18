require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/refile",
					semester_2 = "~/notes/semester-2",
					life = "~/notes/life",
				},
			},
		},
		["core.concealer"] = {},
		["core.integrations.image"] = {},
		["core.latex.renderer"] = {},
	},
})
