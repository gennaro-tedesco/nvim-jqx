local config = require("nvim-blast.config")

local function floating_window(geometry)
   -- create internal window
   local total_width = vim.api.nvim_get_option("columns")
   local total_height = vim.api.nvim_get_option("lines")
   local win_width = geometry.width <=1 and math.ceil(total_width * geometry.width) or total_width
   local win_height = geometry.height <=1 and math.ceil(total_height * geometry.height) or total_height
   local win_opts = {
	  relative = 'win',
	  width = win_width,
	  height = win_height,
	  row = math.ceil((total_height - win_height) / 2 - 1),
	  col = math.ceil(total_width - win_width)/2,
	  focusable = true,
	  style = 'minimal'
   }
   local buf = vim.api.nvim_create_buf(false, true)

   -- create external window
   local border_opts = {
	  style = "minimal",
	  relative = "editor",
	  width = win_width + 2,
	  height = win_height + 2,
	  row = math.ceil((total_height - win_height) / 2 - 1) - 1,
	  col = math.ceil(total_width - win_width)/2 - 1
   }
   local border_buf = vim.api.nvim_create_buf(false, true)
   local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
   local middle_line = '║' .. string.rep(' ', win_width) .. '║'
   for _=1, win_height do
	  table.insert(border_lines, middle_line)
   end
   table.insert(border_lines, '╚'..string.rep('═', win_width)..'╝')
   vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

   vim.api.nvim_open_win(border_buf, true, border_opts)
   vim.api.nvim_open_win(buf, 1, win_opts)
   vim.cmd('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
   return buf
end

local function set_json_opts(buf)
   vim.api.nvim_buf_set_option(buf, 'filetype', 'json')
   vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
   vim.api.nvim_buf_set_option(buf, 'modifiable', false)
   vim.api.nvim_buf_set_option(buf, 'readonly', true)
   vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', ':q<CR>', { nowait = true, noremap = true, silent = true })
end

return {
   floating_window = floating_window,
   set_json_opts = set_json_opts,
}
