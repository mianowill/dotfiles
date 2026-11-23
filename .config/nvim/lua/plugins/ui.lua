local function fortune_section(opts)
  opts = opts or {}
  local width = opts.width or 60
  local justify = opts.justify or false -- set to true for full-justified block


  -- Use { "fortune", "-s", "-n", "160", "zippy" } if you want to cap total quote length
  local raw = vim.fn.system({ "fortune", "zippy" })
  if vim.v.shell_error ~= 0 or not raw or raw == "" then
    return {}
  end

  -- Collapse fortune's pre-existing line breaks/extra whitespace so we can re-wrap cleanly
  local text = raw:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

  -- Word-wrap without breaking words
  local lines = {}
  local current = ""
  for word in text:gmatch("%S+") do
    if current == "" then
      current = word

    elseif vim.fn.strdisplaywidth(current) + 1 + vim.fn.strdisplaywidth(word) <= width then
      current = current .. " " .. word
    else
      table.insert(lines, current)
      current = word
    end
  end
  if current ~= "" then
    table.insert(lines, current)
  end

  -- Optional: full-justify all lines except the last, inside a centered block
  if justify and #lines > 1 then
    for i = 1, #lines - 1 do
      local words = vim.split(lines[i], " ", { plain = true })
      if #words > 1 then
        local gaps = #words - 1
        local spaces_needed = width - vim.fn.strdisplaywidth(lines[i]) + gaps
        local base = math.floor(spaces_needed / gaps)
        local extra = spaces_needed % gaps
        local parts = {}
        for j, w in ipairs(words) do
          table.insert(parts, w)
          if j <= gaps then
            table.insert(parts, string.rep(" ", base + (j <= extra and 1 or 0)))

          end
        end
        lines[i] = table.concat(parts)
      end
    end
    -- Right-pad the last line to `width` so it aligns with the left edge of the justified block
    -- (remove this line if you prefer the last line to be centered instead)
    local pad = math.max(0, width - vim.fn.strdisplaywidth(lines[#lines]))
    lines[#lines] = lines[#lines] .. string.rep(" ", pad)
  end

  local items = {}
  for i, line in ipairs(lines) do
    table.insert(items, {
      text = { { line, hl = "SnacksDashboardDesc" } }, -- or "Comment"
      align = "center",
      padding = (i == #lines) and 1 or 0,
    })
  end
  return items
end

return {
  {
    "0xferrous/ansi.nvim",
    config = function()
      require("ansi").setup({
        auto_enable = true, -- Auto-enable for configured filetypes
        filetypes = { "log", "ansi", "devlog" }, -- Filetypes to auto-enable
      })
    end,
  },
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   opts = {},
  -- },
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
      search = {
        -- trigger = "\\",
      },
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
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "*" } },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        "icon",
        "size",
        "mtime",
      },
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "tmux"
      -- Target the last active tmux pane automatically
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
    end,
  },
  {
    "snacks.nvim",
    opts = {
      picker = {
        matcher = { frecency = true },
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = false,
          },
        },
      },
      explorer = {
        enabled = false,
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
          -- {
          --   section = "terminal",
          --   cmd = "fortune -n 60 zippy | while IFS= read -r line; do printf '%*s\n' $(( (60 + ${#line}) / 2 )) \"$line\"; done",
          --   ttl = 30,
          --   width = 60,
          --   height = 3,
          -- },
          function()
            return fortune_section({ width = 60, justify = true })
          end,
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { icon = "⌨ ", key = "i", desc = "New File", action = ":ene | startinsert" },
        },
      },
    },
    keys = {
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },
}
