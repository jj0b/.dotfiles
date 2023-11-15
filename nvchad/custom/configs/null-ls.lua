local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
	-- TypeScript
	lint.eslint_d,
	formatting.prettier,
	code_actions.eslint_d,

	-- Lua
	formatting.stylua,

	-- Go
	formatting.gofumpt,
	formatting.goimports_reviser,
	formatting.golines,

	-- Python
	null_ls.builtins.formatting.black,

	--  lint.shellcheck,
}


null_ls.setup({

	debug = true,
	sources = sources,
	-- autoformat on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
