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

-- servers with default config
local servers = {
  -- Lua
  "lua_ls", -- Lua language server

  -- Web Development
  "html", -- HTML language server
  "htmx", -- HTMX language server
  "cssls", -- CSS language server
  "ts_ls", -- TypeScript/JavaScript language server
  "tailwindcss", -- Tailwind CSS language server
  "svelte", -- Svelte language server
  "emmet_ls", -- Emmet language server for HTML/CSS snippets
  "graphql", -- GraphQL language server

  -- Go
  "gopls", -- Go language server
  "templ", -- Go template language server

  -- Python
  "pyright", -- Static type checker for Python
  "ruff", -- Fast Python linter

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
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom server configurations

-- Lua language server configuration
lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

-- ESLint configuration
lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Enable formatting
    client.server_capabilities.documentFormattingProvider = true
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    workingDirectory = { mode = "auto" },
  },
}

-- Tailwind CSS configuration
lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
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
}
