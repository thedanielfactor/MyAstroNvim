-- Customize None-ls sources

---@type LazySpec
return {
  { "jose-elias-alvarez/null-ls.nvim", enabled = false },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    opts = function(_, config)
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"
      --
      -- Check supported formatters and linters
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- typescript
        -- null_ls.builtins.diagnostics.eslint_d.with {
        --   command = "eslint_d",
        --   extra_args = { "--stdin", "--stdin-filename", "$FILENAME" },
        --   condition = function()
        --     return null_ls.utils.root_pattern(
        --       ".eslintrc",
        --       ".eslintrc.json",
        --       ".eslintrc.cjs",
        --       ".eslintrc.js",
        --       ".eslintrc.yml",
        --       ".eslintrc.yaml",
        --       ".eslintrc.json5",
        --       ".eslintrc.toml"
        --     )
        --   end,
        -- },
        null_ls.builtins.formatting.prettierd.with {
          -- extra_args = {
          --   "--semi",
          --   "--arrow-parens",
          --   "avoid",
          --   "--single-quote",
          --   "--jsx-single-quote",
          -- },
          -- -- use prettier only with prettierrc present
          condition = function()
            return require("null-ls.utils").root_pattern(
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs"
            )(vim.api.nvim_buf_get_name(0)) ~= nil
          end,
        },

        -- python
        null_ls.builtins.diagnostics.mypy.with {
          extra_args = { "--ignore-missing-imports" },
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.completion.spell,
      }

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

      return config -- return final config table
    end,
  },
}
