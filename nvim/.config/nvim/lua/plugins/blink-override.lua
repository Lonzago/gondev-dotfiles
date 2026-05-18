-- Disable auto-completion in blink.cmp - only manual trigger
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      -- Disable auto-trigger on keyword (typing characters)
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },
      -- Disable auto-show of menu
      menu = {
        auto_show = false,
      },
    },
  },
}