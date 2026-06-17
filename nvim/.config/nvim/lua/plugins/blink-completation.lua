--   "saghen/blink.cmp",
--   opts = {
--     completion = {
--       -- Disable auto-trigger on keyword (typing characters)
--       trigger = {
--         show_on_keyword = false,
--         show_on_trigger_character = false,
--       },
--       -- Disable auto-show of menu
--       menu = {
--         auto_show = false,
--       },
--     },
--   },
-- }
-- lua/plugins/completion.lua (or your blink.cmp config file)
return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      -- Add blink-cmp-unreal as a dependency
      { "taku25/blink-cmp-unreal" },
    },
    opts = {
      enable_ustruct = true,
      enable_uenum = true,
      sources = {
        -- Enable the "unreal" source
        default = { "lsp", "buffer", "path", "unreal" },
        providers = {
          unreal = {
            module = "blink-cmp-unreal",
            name = "unreal",
            score_offset = 15,
          },
        },
      },
      --... other blink.cmp settings
    },
  },
}

