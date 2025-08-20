return {
  { "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {
      disable_mouse = false,
      disabled_keys = {
   ["<Up>"] = false, -- Allow <Up> key
   ["<Down>"] = false, -- Allow <Up> key
   ["<Right>"] = false, -- Allow <Up> key
   ["<Left>"] = false, -- Allow <Up> key
},
    },
  }
}
