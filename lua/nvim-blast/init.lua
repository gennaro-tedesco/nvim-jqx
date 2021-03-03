-- this module exposes the main interface

local function blast_list()
   local cmd_lines = {}

   for s in vim.fn.system('ls'):gmatch("[^\r\n]+") do
	   table.insert(cmd_lines, s)
   end

   local qf_list = {}
   for _, v in pairs(cmd_lines) do
	  table.insert(qf_list, {filename = v, lnum = 1, col = 10, vcol = 100, text = "asd"})
   end

   local result =  vim.fn.setqflist(qf_list, ' ')
   print(result)
   vim.cmd('copen')
end

return {
   blast_list = blast_list
}
