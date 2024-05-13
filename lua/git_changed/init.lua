local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local plenary_path = require "plenary.path"
local conf = require("telescope.config").values

local git_changed = {}
git_changed.config = {}

local git_status = function(path)
    if path == nil then
        path = "."
    end
    local cmd = string.format("git -C %s status --porcelain -uall --short", tostring(path))

    local f = io.popen(cmd)
    if f == nil then return {} end

    local res = {}
    for line in f:lines() do
        local p = string.gsub(line, ".+%s", "")
        local as_path = plenary_path:new(p)
        table.insert(res, as_path:absolute())
    end
    return res
end

git_changed.changed_files = function(opts)
    opts = opts or require('telescope.themes').get_dropdown({
        previewer = false,
        winblend = 10,
    })
    pickers.new(opts, {
        prompt_title = "edited files",
        finder = finders.new_table {
            results = git_status(vim.fn.getcwd())
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

return git_changed
