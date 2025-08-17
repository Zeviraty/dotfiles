-- Taken from https://github.com/alex-courtis/arch/blob/b5f24e0e7b6554b338e40b3d60f1be437f273023/config/nvim/lua/amc/nvim-tree.lua
-- And then modified
local M = {}

function M.setup()
  local tree = require("nvim-tree")

  tree.setup({
    hijack_cursor = true,
    sync_root_with_cwd = true,
    view = {
      adaptive_size = false,
    },
    renderer = {
      highlight_git = true,
      full_name = true,
      group_empty = false,
      special_files = {},
      symlink_destination = false,
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "signcolumn",
        show = {
          file = true,
          folder = false,
          folder_arrow = true,
          git = false,
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = { "help" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    actions = {
      change_dir = {
        enable = false,
        restrict_above_cwd = true,
      },
      open_file = {
        resize_window = true,
        window_picker = {
          chars = "aoeui",
        },
      },
      remove_file = {
        close_window = false,
      },
    },
    log = {
      enable = false,
      truncate = true,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
    git = {
	enable = true,
	ignore = false,
    },
  })
end

return M
