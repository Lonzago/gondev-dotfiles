return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    window = {
      neo_tree_preview = true,
      mappings = {
        ["p"] = {
          "toggle_preview",
          config = {
            use_float = false,
            use_snacks_image = true,
            use_image_nvim = true,
          },
        },
        -- ["l"] = "focus_preview",
        ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
      },
    },
  },
}
