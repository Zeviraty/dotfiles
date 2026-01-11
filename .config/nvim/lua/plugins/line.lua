return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function(_, opts)
        -- Ensure the section exists
        opts.sections = opts.sections or {}
        opts.sections.lualine_x = opts.sections.lualine_x or {}

        -- Insert our custom fold indicator
        table.insert(opts.sections.lualine_x, 1, function()
            local line = vim.fn.line(".")
            local level = vim.fn.foldlevel(line)

            if level == 0 then
                return ""  -- not inside a fold
            end

            -- Determine fold start and end
            local start_line = line
            while start_line > 1 and vim.fn.foldlevel(start_line - 1) >= level do
                start_line = start_line - 1
            end

            local fold_end = vim.fn.foldclosedend(line)
            if fold_end == -1 then
                local last = vim.fn.line("$")
                fold_end = line
                for l = line + 1, last do
                    if vim.fn.foldlevel(l) < level then
                        fold_end = l - 1
                        break
                    else
                        fold_end = l
                    end
                end
            end

            local count = fold_end - start_line + 1
            return "> [" .. count .. " lines]"
        end)

        return opts
    end
}

