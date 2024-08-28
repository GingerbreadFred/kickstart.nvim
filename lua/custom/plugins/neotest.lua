return {
  {
    'GingerbreadFred/neotest-ctest',
    branch = 'SearchDepthFix',
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Other neotest dependencies here
      'GingerbreadFred/neotest-ctest',
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
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        adapters = {
          require('neotest-ctest').setup {
            root = function(dir)
              return require('neotest.lib').files.match_root_pattern('CMakePresets.json', '.git')(dir)
            end,
            is_test_file = function(file_path)
              local elems = vim.split(file_path, require('neotest.lib').files.sep, { plain = true })
              local name, extension = unpack(vim.split(elems[#elems], '.', { plain = true }))
              local supported_extensions = { 'cpp', 'cc', 'cxx' }
              return vim.tbl_contains(supported_extensions, extension) and vim.endswith(name, 'Test') or false
            end,
            frameworks = { 'gtest' },
          },
        },
        quickfix = {
          enabled = true,
          open = true,
        },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
      }
    end,
  },
}
