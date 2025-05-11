return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    ft = {
      "css",
      "html",
    },
    config = function()
      require("colorizer").setup {
        "css",
        "html",
      }
    end,
  },
}
