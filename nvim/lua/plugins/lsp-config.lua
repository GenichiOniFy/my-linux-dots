return
{
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "pyright", "clangd", "hyprls", "harper_ls","asm_lsp"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.clangd.setup({
                capabilities = capabilities;
            })
            lspconfig.hyprls.setup({
                capabilities = capabilities
            })
            lspconfig.harper_ls.setup({
                capabilities = capabilities
            })
            lspconfig.asm_lsp.setup({
                capabilities = capabilities;
                filetypes = { "asm" };
                cmd = { "asm-lsp" };
                settings = { diagnostics = { enable = false } };
                root_dir = require'lspconfig'.util.root_pattern(".git", ".");
                handlers = {
                    -- Отключаем сообщения об ошибках
                    ["textDocument/publishDiagnostics"] = function() end
                },
            })
            vim.keymap.set('n','K', vim.lsp.buf.hover,{})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, '<C-a>', vim.lsp.buf.code_action, {})
        end
    }
}
