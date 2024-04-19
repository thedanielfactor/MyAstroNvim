return {
  "nvim-neorg/neorg",
  cmd = "Neorg",
  ft = "norg", 
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
            workspaces = {
              ae = "~/notes/ae",
              bd = "~/notes/bd",
              mynotes = "~/notes/mynotes",
            },
          },
        },
      },
    }
  end,
}
