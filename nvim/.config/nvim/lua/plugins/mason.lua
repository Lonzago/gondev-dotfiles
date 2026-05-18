return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      "markdownlint-cli2",
      "markdown-toc",
      "gopls",
    },
  },
}