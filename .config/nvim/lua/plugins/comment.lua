return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }

      --local comment_ft = require "Comment.ft"
      --comment_ft.set("lua", { "--%s", "--[[%s]]" })
    end,
  },
}
