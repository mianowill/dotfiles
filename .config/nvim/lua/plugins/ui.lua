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
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", "<cmd>:CodeDiff file HEAD<CR>", "Diff This File")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
      -- stylua: ignore end
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      picker = {
        matcher = { frecency = true },
        explorer = {
          -- replace_netrw = false,
          hidden = true,
        },
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
