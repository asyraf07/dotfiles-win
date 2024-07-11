return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    "node_modules"
                }
            },
            pickers = {
                find_files = {
                    hidden = true
                }
            }
        }

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', ';f', builtin.find_files, {})
        vim.keymap.set('n', ';g', builtin.live_grep, {})
        vim.keymap.set('n', ';b', builtin.buffers, {})
        vim.keymap.set('n', ';h', builtin.help_tags, {})
    end
}
