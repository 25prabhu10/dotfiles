return {
  {
    "lervag/vimtex",
    event = "VeryLazy",
    ft = "tex",
    init = function()
      -- vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

      vim.g.vimtex_format_enabled = 1

      vim.g.vimtex_compiler_method = "tectonic"
    end,
  },
}
