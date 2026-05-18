return {
  -- LSP Servers: Python, Markdown, TypeScript
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        marksman = {},
        tsserver = {},
        clangd = {
          keys = {
            { "<leader>cH", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
          },
        },
      },
    },
  },
  -- TypeScript LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
    },
    opts = {
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}

