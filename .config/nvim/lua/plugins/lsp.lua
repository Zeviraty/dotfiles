return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{ "ms-jpq/coq_nvim", branch = "coq" },
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		{ 'ms-jpq/coq.thirdparty', branch = "3p" },
	},
	init = function()
    		vim.g.coq_settings = {
			auto_start = 'shut-up',
			completion = { always = false },
			keymap = { manual_complete = "<C-a>" }
		}
	end,
	config = function()
		vim.lsp.config('v_analyzer',coq.lsp_ensure_capabilities())
		vim.lsp.enable('v_analyzer')
		vim.lsp.config('pyright',coq.lsp_ensure_capabilities())
		vim.lsp.enable('pyright')
	end
}
