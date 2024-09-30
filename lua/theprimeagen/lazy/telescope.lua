return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        -- search is limited to the current directory only
        vim.keymap.set('n', '<leader>pp', function()
            local Cdir = vim.fn.expand('%:p')
                if Cdir == "" then
                    builtin.find_files()
                else
                    Cdir = string.gsub(Cdir, "oil://", "");
                    Cdir = string.gsub(Cdir, "[^/]+%.%w+$", "");
                    builtin.find_files({ cwd = Cdir })
                end
            end, {})
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        -- look for .git folder, remove the error when using nvim /path
        vim.keymap.set('n', '<C-p>', function()
            local git_dir = vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
                if git_dir == "" then
                    builtin.git_files()
                else
                    builtin.git_files({ cwd = vim.fn.getcwd() .. "/" .. git_dir })
                end
            end, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}

