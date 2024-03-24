return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    -- Fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      event = "VeryLazy",
      keys = {
        {
          "<leader>de",
          function()
            require("dapui").eval()
          end,
          desc = "Eval",
          mode = { "n", "v" },
        },
        {
          "<leader>dE",
          function()
            require("dapui").eval(vim.fn.input "[DAP] Expression > ")
          end,
          desc = "Evaluate expression",
          mode = { "n", "v" },
        },
        {
          "<leader>du",
          function()
            require("dapui").toggle {}
          end,
          desc = "Debug: See last session result.",
        },
      },
      opts = {},
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"

        dapui.setup(opts)

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
      end,
    },

    -- Virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        enabled = true,

        -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
        enabled_commands = false,

        -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_changed_variables = true,
        highlight_new_as_changed = true,

        -- prefix virtual text with comment string
        commented = false,

        show_stop_reason = true,

        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      },
    },
  },
  config = function()
    -- local Config = require "lazyvim.config"
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- for name, sign in pairs(Config.icons.dap) do
    --   sign = type(sign) == "table" and sign or { sign }
    --   vim.fn.sign_define(
    --     "Dap" .. name,
    --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --   )
    -- end

    local dap = require "dap"

    -- Basic debugging keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug: Breakpoint Condition" })

    vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })

    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "Go to line (no execute)" })
    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dS", dap.session, { desc = "Session" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>dw", require("dap.ui.widgets").hover, { desc = "Widgets" })

    -- C/C++
    -- dap.adapters.c = {
    --   name = "lldb",
    --
    --   type = "executable",
    --   attach = {
    --     pidProperty = "pid",
    --     pidSelect = "ask",
    --   },
    --   command = "lldb-vscode-11",
    --   env = {
    --     LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    --   },
    -- }
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch C/C++",
        type = "lldb",
        request = "launch",
        program = function()
          if vim.fn.expand("%"):match "^.+(%..+)$" == ".cpp" then
            os.execute("clang++ -g -Wall -Wextra -Wdocumentation " .. vim.fn.expand "%")
          else
            os.execute("clang -g -Wall -Wextra -Wdocumentation " .. vim.fn.expand "%")
          end
          -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          return vim.fn.getcwd() .. "/a.out"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        -- runInTerminal = true,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    -- dap.configurations.rust = dap.configurations.cpp

    -- Python
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb {
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        }
      else
        cb {
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        }
      end
    end

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/bin/python"
          end
        end,
      },
    }
  end,
}
