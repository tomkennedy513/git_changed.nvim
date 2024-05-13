local git_changed = require('git_changed')

return require("telescope").register_extension {
    exports = {
        changed_files = git_changed.changed_files,
        git_changed = git_changed.changed_files,
    }
}
