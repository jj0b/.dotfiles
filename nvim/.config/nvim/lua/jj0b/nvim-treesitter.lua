require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
  ensure_installed = { 
      "javascript", 
      "typescript", 
      "go", 
      "python", 
      "lua", 
      "json", 
      "markdown", 
      "yaml", 
      "vim",
      "html" 
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,
}