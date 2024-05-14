local helpers = {}

helpers.dirname = function(path)
    if path == "" then
        return vim.fn.getcwd()
    end

    local dir = path:match("(.*[/\\])")
    if string.sub(dir, -1, -1) == "/" then
        dir = string.sub(dir, 1, -2)
    end
    return dir
end

helpers.current_buffer_working_dir = function()
    return helpers.dirname(vim.api.nvim_buf_get_name(0))
end

return helpers
