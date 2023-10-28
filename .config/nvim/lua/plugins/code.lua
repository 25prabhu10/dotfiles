return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    -- config = function()
    --   require("Comment").setup {
    --     pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    --   }
    --
    --   --local comment_ft = require "Comment.ft"
    --   --comment_ft.set("lua", { "--%s", "--[[%s]]" })
    -- end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
}
