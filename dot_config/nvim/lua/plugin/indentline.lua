local M = {
  "lukas-reineke/indent-blankline.nvim",
  commit = "1e79f3dd6e750c5cb4ce99d1755a3e17025c0f47",
  event = "BufReadPre",
  main = 'ibl',
  opts = {
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      injected_languages = false,
      highlight = { "Function", "Label" },
      priority = 500,
    }
  }
}

return M
