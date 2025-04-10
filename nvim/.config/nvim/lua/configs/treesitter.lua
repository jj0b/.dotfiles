pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    -- Vim/Editor
    "vim",
    "vimdoc",

    -- Web Development
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "svelte",
    "graphql",
    "regex",

    -- Backend Languages
    "python",
    "rust",
    "go",
    "gomod",
    "gosum",
    "templ",
    "php",

    -- Shell/System
    "bash",
    "make",
    "awk",

    -- Data/Config Formats
    "json",
    "yaml",
    "toml",
    "xml",
    "ini",
    "csv",

    -- Documentation/Markup
    "markdown",
    "markdown_inline",
    "rst",

    -- Database
    "sql",

    -- Blockchain
    "solidity",

    -- DevOps/Tools
    "dockerfile",
    "gitignore",
    "hcl",
    "cmake",
    "proto",

    -- Scripting
    "lua",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

