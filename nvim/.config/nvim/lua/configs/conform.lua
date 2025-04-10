local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },

    -- Web Development
    html = { "rustywind", "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "rustywind", "prettier" },
    typescriptreact = { "rustywind", "prettier" },
    svelte = { "rustywind", "prettier" },
    graphql = { "prettier" },

    -- Go
    go = { "gofumpt" },
    templ = { "templ" },

    -- Shell
    sh = { "shfmt" },

    -- Data & Config Formats
    json = { "prettier" },
    yaml = { "prettier" },
    toml = { "taplo" },

    -- Documentation
    markdown = { "prettier" },

    -- Docker
    dockerfile = { "dockerfile-formatter" },
    docker_compose = { "prettier" },

    -- Build Systems
    make = { "makefmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
