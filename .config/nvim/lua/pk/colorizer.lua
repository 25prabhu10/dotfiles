local M = {}

function M.setup()
  require("colorizer").setup({
    "css",
    "scss",
    "javascript",
    html = {
      mode = "foreground",
    },
  }, {
    css = true,
  })
end

return M
