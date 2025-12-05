return {
  {
    "0xferrous/ansi.nvim",
    config = function()
      require("ansi").setup({
        auto_enable = false, -- Auto-enable for configured filetypes
        filetypes = { "log", "ansi", "devlog" }, -- Filetypes to auto-enable
      })
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
  },
  {
    "Shatur/neovim-ayu",
  },
  {
    "snacks.nvim",
    opts = {
      picker = {
        matcher = { frecency = true },
      },
      explorer = {
        -- replace_netrw = false,
      },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
             .======.             
             | NVIM |             
             |      |             
             |      |             
    .========'      '========.    
    |   _      xxxx      _   |    
    |  /_;-.__ / _\  _.-;_\  |    
    |     `-._`'`_/'`.-'     |    
    '========.`\   /`========'    
             | |  / |             
             |/-.(  |             
             |\_._\ |             
             | \ \`;|             
             |  > |/|             
             | / // |             
             | |//  |             
             | \(\  |             
             |  ``  |             
             |      |             
             |      |             
             |      |             
             |      |             
 \\    _  _\\| \//  |//      \// _
^ `^`^ ^`` `^ ^` ``^^`  `^^` `^ `^]],
        },
        sections = {
          { section = "header" },
          {
            section = "terminal",
            cmd = "fortune -n 60 zippy | while IFS= read -r line; do printf '%*s\n' $(( (60 + ${#line}) / 2 )) \"$line\"; done",
            ttl = 30,
            width = 60,
            height = 3,
          },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
  },
}
