return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<m-h><m-m>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<m-h><m-l>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end)
    end

    -- vim.keymap.set("n", "<leader>a", mark.add_file)
    -- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    --
    -- vim.keymap.set("n", "<C-h>", function()
    --   ui.nav_file(1)
    -- end)
    -- vim.keymap.set("n", "<C-t>", function()
    --   ui.nav_file(2)
    -- end)
    -- vim.keymap.set("n", "<C-n>", function()
    --   ui.nav_file(3)
    -- end)
    -- vim.keymap.set("n", "<C-s>", function()
    --   ui.nav_file(4)
    -- end)
  end,
}
