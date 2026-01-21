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
