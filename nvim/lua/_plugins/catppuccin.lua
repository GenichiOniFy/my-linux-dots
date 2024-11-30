return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true})
        vim.cmd.colorscheme "catppuccin"
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" }
        })
    end
}

