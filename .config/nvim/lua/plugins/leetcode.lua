return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
	"nvim-telescope/telescope.nvim"
    },
    opts = {
	lang = "Python3",
    },
}
