return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { 
                "nvim-lua/plenary.nvim", 
                "nvim-tree/nvim-web-devicons", 
                "MunifTanjim/nui.nvim"},
    config = function()
        -- Функция для переключения состояния Neo-tree
        local function toggle_neotree()
            if vim.fn.exists("t:neotree") == 1 then
                vim.cmd("Neotree close")
            else
                vim.cmd("Neotree filesystem reveal left")
            end
        end

        vim.keymap.set('n', '<C-n>', toggle_neotree, {})
    end
}
