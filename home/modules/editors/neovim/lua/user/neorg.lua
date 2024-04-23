require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          projects = "~/notes/projects",
          school = "~/notes/school",
        },
      },
    },
    ["core.concealer"] = {},
    ["core.export"] = {},
  },
})
