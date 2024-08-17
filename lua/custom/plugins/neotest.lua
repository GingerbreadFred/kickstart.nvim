return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Other neotest dependencies here
      'orjangj/neotest-ctest',
    },
    keys = function()
      local neotest = require 'neotest'

      return {
        {
          '<leader>tf',
          function()
            neotest.run.run(vim.fn.expand '%')
          end,
          desc = 'Run File',
        },
        {
          '<leader>tt',
          function()
            neotest.run.run()
          end,
          desc = 'Run Nearest',
        },
        {
          '<leader>tw',
          function()
            neotest.run.run(vim.loop.cwd())
          end,
          desc = 'Run Workspace',
        },
        {
          '<leader>tr',
          function()
            -- This will only show the output from the test framework
            neotest.output.open { short = true, auto_close = true }
          end,
          desc = 'Results (short)',
        },
        {
          '<leader>tR',
          function()
            -- This will show the classic CTest log output.
            -- The output usually spans more than can fit the neotest floating window,
            -- so using 'enter = true' to enable normal navigation within the window
            -- is recommended.
            neotest.output.open { enter = true }
          end,
          desc = 'Results (full)',
        },
        {
          '<leader>ts',
          function()
            neotest.summary.toggle()
          end,
          desc = 'Test Summary',
        },
      }
    end,
    config = function()
      -- Optional, but recommended, if you have enabled neotest's diagnostic option

      require('neotest').setup {
        discovery = {
          filter_dir = function(name, rel_path, root)
            return name ~= 'thirdparty' and name ~= 'build'
          end,
        },
        adapters = {
          -- Load with default config
          require('neotest-ctest').setup {},
        },
        quickfix = {
          enabled = true,
          open = true,
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
      }
    end,
  },
}
