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
	options = { theme = 'codedark'},
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
vim.api.nvim_create_autocmd("FileType", {
  pattern = "v",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "js",
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

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

--vim.diagnostic.config({ virtual_text = true })
vim.diagnostic.config({
  signs = true
})

vim.opt.signcolumn = "yes"

-- Save view when leaving a buffer
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*.*",
    callback = function()
        vim.cmd("mkview")
    end,
})

-- Load view silently when entering a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.*",
    callback = function()
        vim.cmd("silent! loadview")
    end,
})

vim.opt.fillchars = { fold = ' ' }
vim.opt.foldtext = "v:lua.FoldText()"
vim.cmd([[hi Folded guibg=NONE ctermbg=NONE]])

function _G.FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local count = vim.v.foldend - vim.v.foldstart + 1
  local width = vim.fn.winwidth(0)
  local suffix = " [" .. count .. " lines]"
  local target_width = width - #suffix - 5
  line = line:gsub("\t", string.rep(" ", vim.o.tabstop))

  if vim.fn.strdisplaywidth(line) > target_width then
    line = vim.fn.strcharpart(line, 0, target_width - 3) .. "..."
  end

  local padding = string.rep(" ", target_width - vim.fn.strdisplaywidth(line))
  return "> " .. line .. padding .. suffix
end

vim.api.nvim_set_keymap('n', '<leader>xf', '', {
  noremap = true,
  callback = function()
    for _, client in ipairs(vim.lsp.buf_get_clients()) do
      require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
    end
  end
})

vim.g.doge_doc_standard_python = 'numpy'
vim.g.doge_enable_mappings = 0
vim.keymap.set('n', '<Leader>s', '<Plug>(doge-generate)')

vim.g.doge_python_settings = {
  single_quotes = 1,
  omit_redundant_param_types = 0,
}

vim.opt.cmdheight = 0
vim.opt.shortmess:append("sI")
