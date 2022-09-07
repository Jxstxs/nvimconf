local M = {}

local key = require("nvimconf.core.keys")
local nmap = key.nmap
local cmd = key.cmd
local opts = key.opts({ silent = true })

nmap({
	{ "<S-h>", cmd("BufferLineCyclePrev"), opts },
	{ "<S-l>", cmd("BufferLineCycleNext"), opts },
})

local reload_module = function()
	vim.ui.input({ prompt = "Reload: " }, function(input)
		if input ~= nil then
			require("plenary.reload").reload_module(input)
		end
	end)
end

M.keys = {
	n = {
		opts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		},
		mappings = {
			w = { cmd("w!"), "Save" },
			q = { cmd("Bdelete!"), "Close Buffer" },
			Q = { cmd("q!"), "Quit Nvim" },
			h = { cmd("nohl"), "Clear Highlights" },
			e = { cmd("RnvimrToggle"), "Ranger" },
			E = { cmd("NvimTreeToggle"), "Neotree" },
			c = { cmd("lua require('Comment.api').toggle_current_linewise()"), "Comment" },
			-- m = { push_stack("page_moving"), "Movement" },
		},
	},
	v = {
		opts = {
			mode = "v",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		},
		mappings = {},
	},
}

return M
