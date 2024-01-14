local M = {}

local core = require("req-check.core")

function M.setup()
	vim.api.nvim_create_user_command("ReqCheck", function()
		core.check_requirement()
	end, { nargs = 0 })

	vim.api.nvim_create_user_command("ReqUpdate", function()
		core.update_requirements()
	end, { nargs = 0 })

	vim.api.nvim_create_user_command("ReqInstall", function()
		core.reinstall_requirements()
	end, { nargs = 0 })
end

return M
