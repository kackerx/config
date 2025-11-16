return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        enabled = false,
        opts = {
            size = 20,
            -- TODO: add my own keymapping to <space-t>
            -- open_mapping = "",
            hide_numbers = false,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 3,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },

        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            function _G.set_terminal_keymaps()
                local optss = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n><C-y>]], optss)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], optss)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], optss)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], optss)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], optss)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], optss)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], optss)
            end

            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                dir = "git_dir",
                direction = "float",
                float_opts = {
                    border = "double",
                },
                -- function to run on opening the terminal
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
                end,
                -- function to run on closing the terminal
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })

            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua _lazygit_toggle()<CR>",
                { noremap = true, silent = true })

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    }

}
