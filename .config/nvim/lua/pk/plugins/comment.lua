return {
  -- Comments
  {
    "numToStr/Comment.nvim",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      ---@diagnostic disable-next-line: missing-fields
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }

      --local comment_ft = require "Comment.ft"
      --comment_ft.set("lua", { "--%s", "--[[%s]]" })
    end,
  },
}
