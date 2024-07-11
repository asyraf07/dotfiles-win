function Run()
    if vim.bo.filetype == 'python' then
        local filename = vim.api.nvim_buf_get_name(0)
        vim.api.nvim_command(":!python " .. filename)
    else
        print("runtime hasn't been setup yet")
    end
end

vim.keymap.set("n", "<leader>r", ":lua Run()<CR>")
