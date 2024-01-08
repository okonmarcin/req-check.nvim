local M = {}

local function splitString(str)
	local results = {}
	for word in string.gmatch(str, "%S+") do
		table.insert(results, word)
	end
	return { results[1], results[2], results[3] }
end


function M.check_requirement()
	local find_file_output = io.popen([[find . -type f -name '*.in']])
	local req_in_file_path
	if find_file_output then
		req_in_file_path = find_file_output:read("*l")
		find_file_output:close()
		local req_in_file_content = io.open(req_in_file_path, "r")
		local installed_dependencies = {}
		if req_in_file_content then
			for line in req_in_file_content:lines() do
				table.insert(installed_dependencies, line)
			end
			local outdated_deps_output = io.popen([[pip list --outdated]], "r")
			local final_dependencies_to_be_updated = {}
			if outdated_deps_output then
				for line in outdated_deps_output:lines() do
					for _, prefix in ipairs(installed_dependencies) do
						if string.sub(line, 1, string.len(prefix)) == prefix then
							table.insert(final_dependencies_to_be_updated,
								splitString(line))
						end
					end
				end
				outdated_deps_output:close()
			else
				require("notify")("Everything is up to date!", "info", { title = "Requirements Check" })
			end
			local message = ""
			for _, row in ipairs(final_dependencies_to_be_updated) do
				message = message .. row[1] .. ": " .. row[2] .. " ---> " .. row[3] .. "\n"
			end
			require("notify")(message, 'warn', { title = 'Requirements Check' })
		else
			require("notify")("No requirements found in requirement.in file", "warn",
				{ title = "Requirements Check" })
		end
	else
		require("notify")("No requirements files found", "warn", { title = "Requrements Check" })
	end
end

return M
