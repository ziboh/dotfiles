local M = {}
HOME = os.getenv("HOME")
local picker = require("window-picker")

function M.pick_windows()
	local picked_window_id = picker.pick_window({
		include_current_win = true,
	}) or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end

-- Swap two windows using the awesome window picker
function M.swap_windows()
	local window = picker.pick_window({
		include_current_win = false,
	})
	local target_buffer = vim.fn.winbufnr(window)
	-- Set the target window to contain current buffer
	vim.api.nvim_win_set_buf(window, 0)
	-- Set current window to contain target buffer
	vim.api.nvim_win_set_buf(0, target_buffer)
end

-- support passing args
M.find_next_start = function(str, cur_idx)
	while cur_idx <= #str and str:sub(cur_idx, cur_idx) == " " do
		cur_idx = cur_idx + 1
	end
	return cur_idx
end

M.str2argtable = function(str)
	-- trim spaces
	str = string.gsub(str, "^%s*(.-)%s*$", "%1")
	local arg_list = {}

	local start = 1
	local i = 1
	local quote_refs_cnt = 0
	while i <= #str do
		---@diagnostic disable-next-line: undefined-field
		local c = str:sub(i, i)
		if c == '"' then
			quote_refs_cnt = quote_refs_cnt + 1
			start = i
			i = i + 1
			-- find next quote
			---@diagnostic disable-next-line: undefined-field
			while i <= #str and str:sub(i, i) ~= '"' do
				i = i + 1
			end
			if i <= #str then
				quote_refs_cnt = quote_refs_cnt - 1
				---@diagnostic disable-next-line: undefined-field
				arg_list[#arg_list + 1] = str:sub(start, i)
				start = M.find_next_start(str, i + 1)
				i = start
			end
			-- find next start
		elseif c == " " then
			---@diagnostic disable-next-line: undefined-field
			arg_list[#arg_list + 1] = str:sub(start, i - 1)
			start = M.find_next_start(str, i + 1)
			i = start
		else
			i = i + 1
		end
	end

	-- add last arg if possiable
	if start ~= i and quote_refs_cnt == 0 then
		---@diagnostic disable-next-line: undefined-field
		arg_list[#arg_list + 1] = str:sub(start, i)
	end
	return arg_list
end

M.get_workpath_python_resolve = function()
	-- 获取当前工作目录
	local workpath = vim.fn.getcwd()
	-- 判断当前目录是否存在.python_version文件
	local python_version_file = workpath .. "/.python-version"
	local file_exist = io.open(python_version_file, "r") ~= nil

	if file_exist then
		-- 读取python版本号
		local python_version = io.open(python_version_file, "r"):read("*l")
		-- 获取pyenv的安装目录
		local pyenv_root = vim.fn.getenv("PYENV_ROOT")
		return pyenv_root .. "/versions/" .. python_version .. "/bin/python"
	end
	if vim.fn.getenv("PYENV_ROOT") == nil then
		-- 获取python的路径
		local python_path = vim.fn.system("which python")
		return python_path
	end
	return vim.fn.getenv("PYENV_ROOT") .. "/shims/python"
end

function M.run_current_python()
	-- 获取当前工作目录
	local workpath = vim.fn.getcwd()
	-- 获取当前缓冲区文件的路径
	local file_path = vim.fn.expand("%:p")
	vim.cmd("TermExec cmd=" .. [['cd ]] .. workpath .. [[ && python ]] .. file_path .. [[']])
end

function M.delete_other_buffers()
	local current_buf = vim.fn.bufnr()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if bufnr ~= current_buf then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
	end
end

function M.delete_from_ft(filetype)
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local get_filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if get_filetype == filetype then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
	end
end

function M.close_undotree()
	local undotree_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		-- 检查buffer对应的文件类型是否为undotree
		if vim.bo[buf].filetype == "undotree" then
			undotree_win = win
			break
		end
	end

	if undotree_win ~= nil then
		vim.api.nvim_win_close(undotree_win, true)
	end
end

return M
