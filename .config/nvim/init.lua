-- Lazy
require("config.lazy")

-- NETRW
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Nvim Tree
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set("n", "<Space>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#5c6370", italic = true })
  end,
})

vim.g.codestats_api_key = 'SFMyNTY.ZW1WMmRtaz0jI01qVTBPVGc9.Sr6ACZzinG8q2ukZR6bmiBDx26gZJxk9uMrxfq2Ebdk'

local lualine = require('lualine')
local lualineconfig = {
	options = { theme = 'codedark'}	
}
lualine.setup(lualineconfig)
vim.opt.cmdheight = 0

require('telescope').load_extension('remote-sshfs')

-- tab
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "py",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.opt.cmdheight = 1
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.opt.cmdheight = 0
  end,
})
