return {
  {

    'GingerbreadFred/nvim-dap',
    branch = 'WindowsLLDBColumn',
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'GingerbreadFred/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('dapui').setup {
        layouts = {
          {
            elements = {
              {
                id = 'stacks',
                size = 1.0,
              },
            },
            position = 'bottom',
            size = 10,
          },
          {
            elements = {
              {
                id = 'watches',
                size = 1.0,
              },
            },
            position = 'bottom',
            size = 10,
          },
        },
      }
      local dap, dapui = require 'dap', require 'dapui'

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-dap',
        name = 'lldb',
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
      }

      vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = '[D]ebug [B]reakpoint' })
      vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = '[D]ebug [C]ontinue' })
      vim.keymap.set('n', '<leader>di', require('dap').step_into, { desc = '[D]ebug Step [I]nto' })
      vim.keymap.set('n', '<leader>do', require('dap').step_over, { desc = '[D]ebug Step [O]ver' })
      vim.keymap.set('n', '<leader>dO', require('dap').step_out, { desc = '[D]ebug Step [O]ut' })

      local float_params = { width = 200, height = 30, enter = true }

      vim.keymap.set('n', '<leader>dwb', function()
        require('dapui').float_element('breakpoints', float_params)
      end, { desc = '[D]ebug [W]indow [B]reakpoint' })

      vim.keymap.set('n', '<leader>dws', function()
        require('dapui').float_element('scopes', float_params)
      end, { desc = '[D]ebug [W]indow [S]copes' })

      vim.keymap.set('n', '<leader>dwc', function()
        require('dapui').float_element('console', float_params)
      end, { desc = '[D]ebug [W]indow [C]onsole' })
    end,
  },
}
