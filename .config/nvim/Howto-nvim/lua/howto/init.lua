local M = {}
local http = require("socket.http")
local ltn12 = require("ltn12")

function M.version()


	local response_body = {}

	local _, _, _ = http.request{
		url = "http://localhost:3000/version",
		method = "GET",
		sink = ltn12.sink.table(response_body)
	}
	print(table.concat(response_body))
end

function M.popup_layout()
local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create prompt window
  local prompt_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(prompt_buf, true, {
    relative = 'editor',
    width = width,
    height = 3,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = 'Find Files',
    title_pos = 'center',
  })

  -- Create results window
  local results_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(results_buf, true, {
    relative = 'editor',
    width = math.floor(width * 0.5),
    height = height - 3,
    row = row + 3,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = 'Results',
    title_pos = 'center',
  })

  -- Create preview window
  local preview_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(preview_buf, true, {
    relative = 'editor',
    width = math.floor(width * 0.5),
    height = height - 3,
    row = row + 3,
    col = col + math.floor(width * 0.5),
    style = 'minimal',
    border = 'rounded',
    title = 'Preview',
    title_pos = 'center',
  })
end

function M.setup()
	vim.api.nvim_create_user_command("HowtoPop", M.popup_layout, {})
	vim.api.nvim_create_user_command("HowtoVersion", M.version, {})
end

return M
