return function(worktree)
	-- worktree.setup({
	-- change_directory_command = <str>, -- default: "cd",
	-- update_on_change = <boolean> -- default: true,
	-- update_on_change_command = <str> -- default: "e .",
	-- clearjumps_on_change = <boolean> -- default: true,
	-- autopush = <boolean> -- default: false,
	-- })

	worktree.on_tree_change(function(op, metadata)
		if op == worktree.Operations.Switch then
			print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
		end
	end)
end
