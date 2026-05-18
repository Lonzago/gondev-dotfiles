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
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
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