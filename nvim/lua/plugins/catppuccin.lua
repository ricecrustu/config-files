return{ "catppuccin/nvim", name = "catppuccin", priority = 1000 ,
    opts = {
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
        }
    },
    config = function()
        vim.cmd.colorscheme "catppuccin"
    end
}
