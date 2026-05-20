-- return {
--   "nvim-treesitter/nvim-treesitter",
--   opts = {
--     ensure_installed = {
--       "bash",
--       "c",
--       "html",
--       "javascript",
--       "json",
--       "lua",
--       "markdown",
--       "markdown_inline",
--       "python",
--       "query",
--       "regex",
--       "tsx",
--       "typescript",
--       "vim",
--       "yaml",
--       "go",
--       "gomod",
--       "gosum",
--       "gowork",
--     },
--   },
--   config = function(_, opts)
--     vim.api.nvim_create_autocmd("User", {
--       pattern = "TSUpdate",
--       callback = function()
--         require("nvim-treesitter.parsers").cpp = {
--           install_info = {
--             url = "https://github.com/taku25/tree-sitter-unreal-cpp",
--             revision = "e2b94d3bd3ce359ff732116cc21f34ecbecfca50",
--           },
--         }
--       end,
--     })
--
--     require("nvim-treesitter").setup(opts)
--   end,
-- }
-- e.g., in plugins/treesitter.lua

return {
  {
    "taku25/tree-sitter-unreal-cpp",
    opts = {},
    config = function() end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      --...
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").cpp = {
            install_info = {
              url = "https://github.com/taku25/tree-sitter-unreal-cpp",
              revision = "e2b94d3bd3ce359ff732116cc21f34ecbecfca50",
            },
          }
        end,
      })
      require("nvim-treesitter").setup(opts)
    end,
  },
}
