-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- LSP Keybindings Reference:
--   gd        - Go to definition
--   gr        - Show references
--   K         - Show hover documentation
--   <leader>ca - Code actions
--   <leader>ra - Rename symbol
--   <leader>D  - Go to type definition
--   gi        - Go to implementation
--   gD        - Go to declaration

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local default_opts = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Compatibility layer for Neovim 0.10 + 0.11.
-- Uses new vim.lsp.config/enable API when available, falls back to lspconfig.
local function setup_server(name, opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  if vim.lsp and vim.lsp.config and vim.lsp.enable then
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
    return
  end

  if lspconfig[name] then
    lspconfig[name].setup(opts)
  end
end

-- servers with default config
local servers = {
  -- Lua
  -- "lua_ls", -- configured below with custom settings

  -- Web Development
  "html", -- HTML language server
  "htmx", -- HTMX language server
  "cssls", -- CSS language server
  "ts_ls", -- TypeScript/JavaScript language server
  -- "tailwindcss", -- configured below with custom settings
  "graphql", -- GraphQL language server

  -- Go
  "gopls", -- Go language server
  "templ", -- Go template language server

  -- Python
  "pyright", -- Static type checker for Python
  -- "ruff", -- configured below to avoid overlapping hover behavior

  -- Shell/System
  "bashls", -- Bash language server

  -- Data & Config Formats
  "jsonls", -- JSON language server
  "yamlls", -- YAML language server
  "taplo", -- TOML language server

  -- Database
  "sqlls", -- SQL language server

  -- Docker/DevOps
  "dockerls", -- Dockerfile language server
  "docker_compose_language_service", -- Docker Compose language server
}

for _, lsp in ipairs(servers) do
  setup_server(lsp)
end

-- Custom server configurations

-- Lua language server configuration
setup_server("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- ESLint configuration
setup_server("eslint", {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Enable formatting
    client.server_capabilities.documentFormattingProvider = true
  end,
  settings = {
    workingDirectory = { mode = "auto" },
  },
})

-- Tailwind CSS configuration
setup_server("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Support for template strings in classnames
          "`([^`]*)`",
          -- Support for clsx/cva function calls
          "clsx\\(([^)]*)\\)",
          "cva\\(([^)]*)\\)",
        },
      },
    },
  },
})

-- Svelte language server configuration
-- Notify svelte-ls when JS/TS files change so cross-file diagnostics stay fresh.
setup_server("svelte", {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)

    local group = vim.api.nvim_create_augroup("SvelteKitTsJsChanges", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.match) })
      end,
    })
  end,
})

-- Emmet language server configuration
setup_server("emmet_ls", {
  filetypes = {
    "html",
    "css",
    "scss",
    "sass",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  },
})

-- Ruff configuration
-- Keep hover/docs on pyright to reduce overlap between Python servers.
setup_server("ruff", {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
})
