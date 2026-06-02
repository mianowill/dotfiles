return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header" },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                -- "off" or "basic" is best if you just want
                -- "clangd style" navigation without strict typing
                typeCheckingMode = "off",
                diagnosticSeverityOverrides = {
                  -- This specifically kills the "Type of X is unknown" noise
                  reportUnknownVariableType = "none",
                  reportUnknownMemberType = "none",
                  reportUnknownArgumentType = "none",
                  reportUnknownParameterType = "none",
                  reportUnknownReturnType = "none",
                  reportAny = "none",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      kind_filter = {
        c = {
          -- "Class",
          -- "Constructor",
          -- "Field",
          "Function",
          -- "Interface",
          -- "Method",
          -- "Module",
          -- "Namespace",
          -- "Package",
          -- "Property",
          -- "Trait",
        },
      },
    },
  },
}
