return {
  {
    "taku25/UnrealDev.nvim",
    dependencies = {
      {
        "taku25/UNL.nvim",
        build = "cargo build --release --manifest-path scanner/Cargo.toml",
        lazy = false,
      },
      "taku25/UEP.nvim",
      "taku25/UEA.nvim",
      "taku25/UBT.nvim",
      "taku25/UCM.nvim",
      "taku25/ULG.nvim",
      "taku25/USH.nvim",
      {
        "taku25/UNX.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
      },
      "taku25/UDB.nvim",
      {
        "taku25/USX.nvim",
        lazy = false,
      },
      {
        "romus204/tree-sitter-manager.nvim",
        opts = {
          ensure_installed = { "cpp", "ushader", "verse" },
          highlight = { "cpp", "ushader", "verse" },
          border = "rounded",
          languages = {
            cpp = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-cpp",
                use_repo_queries = true,
              },
            },
            ushader = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-unreal-shader",
                use_repo_queries = true,
              },
            },
            verse = {
              install_info = {
                url = "https://github.com/taku25/tree-sitter-verse",
                use_repo_queries = true,
              },
            },
          },
        },
        config = function(_, opts)
          vim.filetype.add({
            extension = {
              verse = "verse",
              usf = "ushader",
              ush = "ushader",
            },
          })
          require("tree-sitter-manager").setup(opts)
          local group = vim.api.nvim_create_augroup("MyTreesitter", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = opts.highlight,
            callback = function(args)
              vim.treesitter.start(args.buf)
            end,
          })
        end,
      },
      "nvim-telescope/telescope.nvim",
      "j-hui/fidget.nvim",
      "nvim-lualine/lualine.nvim",
    },
    opts = {
      setup_modules = {
        UBT = true,
        UEP = true,
        ULG = true,
        USH = false,
        UCM = true,
        UEA = false,
        UNX = true,
        UDB = false,
      },
    },
  },
}
