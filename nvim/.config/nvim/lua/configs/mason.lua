dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  ensure_installed = {
    -- Lua
    "lua-language-server", -- Lua language server
    "stylua", -- Lua formatter

    -- Web Development
    "html-lsp", -- HTML language server
    "htmx-lsp", -- HTMX language server
    "typescript-language-server", -- TypeScript/JavaScript language server
    "cssmodules-language-server", -- CSS modules language server
    "@tailwindcss/language-server", -- Tailwind CSS language server
    "svelte-language-server", -- Svelte language server
    "emmet-ls", -- Emmet language server for HTML/CSS snippets
    "prettier", -- Multi-language formatter
    "eslint_d", -- JavaScript/TypeScript linter (daemon)
    "css-lsp", -- CSS language server
    "rustywind", -- Tailwind class organizer

    -- Python
    "python-lsp-server", -- Python language server
    "pyright", -- Static type checker for Python
    "black", -- Python formatter
    "ruff", -- Fast Python linter
    "debugpy", -- Python debugger

    -- Go
    "gopls", -- Go language server
    "gofumpt", -- Stricter Go formatter
    "golangci-lint", -- Go linter

    -- Rust
    "rust-analyzer", -- Rust language server

    -- Shell/System
    "bash-language-server", -- Bash language server
    "shellcheck", -- Shell script linter
    "shfmt", -- Shell formatter

    -- Data Formats
    "json-lsp", -- JSON language server
    "yaml-language-server", -- YAML language server
    "yamlfmt", -- YAML formatter
    "yamllint", -- YAML linter
    "taplo", -- TOML language server

    -- Docker/DevOps
    "dockerfile-language-server", -- Dockerfile language server
    "docker-compose-language-service", -- Docker Compose language server

    -- General
    "markdownlint", -- Markdown linter
    "marksman", -- Markdown language server
    "codespell", -- Spell checker for code
    "misspell", -- Another spell checker

    -- Docker
    "dockerfile-formatter", -- Dockerfile formatter
  },

  max_concurrent_installers = 10,
}

