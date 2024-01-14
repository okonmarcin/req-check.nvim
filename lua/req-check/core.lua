local M   = {}

NAMESPACE = vim.api.nvim_create_namespace("req-check")


function M.check_requirement()
	local buf = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(buf)
	local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	if string.sub(buf_name, -3, -1) ~= ".in" then
		vim.api.nvim_err_writeln("Current file: " .. buf_name .. " is not a Python requirements file.")
		return
	end


	local lib_mapping = {}
	for line_number, lib_name in pairs(buf_lines) do
		if lib_name ~= "" then
			lib_mapping[lib_name] = { line_number }
		end
	end

	local outdated_libs = io.popen([[pip list --outdated --disable-pip-version-check]])
	if outdated_libs then
		outdated_libs:read("*line")
		outdated_libs:read("*line")
		for lib_row in outdated_libs:lines() do
			local splited_values = {}
			for w in string.gmatch(lib_row, "%S+") do
				table.insert(splited_values, w)
			end
			if lib_mapping[splited_values[1]] ~= nil then
				table.insert(lib_mapping[splited_values[1]], splited_values[2])
				table.insert(lib_mapping[splited_values[1]], splited_values[3])
			end
		end
	end
	local all_up_to_date = true
	for _, lib_info in pairs(lib_mapping) do
		if #lib_info == 3 then
			all_up_to_date = false
			vim.api.nvim_buf_set_extmark(buf, NAMESPACE, lib_info[1] - 1, 0, {
				virt_text = { { "# " .. lib_info[2] .. " ===> " .. lib_info[3], "WarningMsg" } },
				virt_text_pos = "eol",
				hl_group = "WarningMsg"
			})
		end
	end
	if all_up_to_date == true then
		vim.api.nvim_out_write("All dependecies are up to date.\n")
	end
end

function M.update_requirements()
	local buf = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(buf)

	local compilation_out = io.popen("pip-compile -r " ..
		buf_name .. " --resolver backtracking -vv")
	if compilation_out then
		vim.api.nvim_out_write("Requirements compiled")
	end
end

function M.reinstall_requirements()
	local buf = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(buf)

	local requirement_txt_filename = string.sub(buf_name, 0, 3) .. ".txt"

	local installation_output = io.popen("pip install -r " .. requirement_txt_filename)
	if installation_output then
		vim.api.nvim_out_write("Installation finished")
		vim.api.nvim_buf_clear_namespace(buf, NAMESPACE, 0, -1)
	end
end

return M
