local M = {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = { 'lua', 'javascript', 'typescript', 'html', 'css', 'tsx' },
            highlight = {
                enable = true
            }
        }
    end
}

return { M }
