local wilder = require("wilder")
wilder.setup({
	modes = { ":", "/", "?" },
	-- next_key = "<C-J>",
	previous_key = "<C-K>",
	-- accept_key = "<Tab>",
	-- reject_key = "<C-BS>",
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer({
			highlighter = wilder.basic_highlighter(),
			pumblend = 0,
			left = { " ", wilder.popupmenu_devicons() },
			right = { " ", wilder.popupmenu_scrollbar() },
		}),
		["/"] = wilder.wildmenu_renderer({
			highlighter = wilder.basic_highlighter(),
		}),
	})
)
