return {
  {
    "taku25/UNL.nvim",
    build = "cargo build --release --manifest-path scanner/Cargo.toml",
    config = function()
      require("UNL").setup()
    end,
  },
  {
    "taku25/UBT.nvim",
    dependencies = {
      "taku25/UNL.nvim",
    },
    config = function()
      require("UBT").setup()
    end,
  },
  {
    "taku25/UCM.nvim",
    dependencies = {
      "taku25/UNL.nvim",
    },
    config = function()
      require("UCM").setup()
    end,
  },
  {
    "taku25/UEP.nvim",
    dependencies = {
      "taku25/UNL.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sharkdp/fd",
      "BurntSushi/ripgrep",
    },
    config = function()
      require("UEP").setup()
    end,
  },
  {
    "taku25/ULG.nvim",
    dependencies = {
      "taku25/UNL.nvim",
      "taku25/UBT.nvim",
    },
    config = function()
      require("ULG").setup()
    end,
  },
  {
    "taku25/neo-tree-unl.nvim",
    dependencies = {
      "taku25/UNL.nvim",
      "nvim-neo-tree/neo-tree.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
}
