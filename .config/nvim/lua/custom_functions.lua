local custom_functions = {}

function custom_functions.strip_trailing_whitespaces()
	local line = vim.fn.line('.')
	local column = vim.fn.col('.')
	vim.cmd[[%s/\s\+$//e]]
	vim.fn.cursor(line, column)
end

function custom_functions.switch_header_source()
	local file_name = vim.fn.expand('%:r:r')
	local file_extension = vim.fn.expand('%:e')

	if file_extension == "hpp" or file_extension == "h" then
		if vim.fn.filereadable(file_name .. ".cpp") ~= 0 then
			vim.cmd(":edit " .. file_name .. ".cpp")
		elseif vim.fn.filereadable(file_name .. ".c") ~= 0 then
			vim.cmd(":edit " .. file_name .. ".c")
		end
	elseif file_extension == "cpp" or file_extension == "c" then
		if vim.fn.filereadable(file_name .. ".hpp") ~= 0 then
			vim.cmd(":edit " .. file_name .. ".hpp")
		elseif vim.fn.filereadable(file_name .. ".h") ~= 0 then
			vim.cmd(":edit " .. file_name .. ".h")
		end
	end
end

return custom_functions
