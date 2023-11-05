local M = {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {
      window = {
        height = 5, -- integer >= 5 | float in range (0, 1)
        width = 0.55, -- integer | float in range (0, 1)
        border = "rounded", -- "none" | "single" | "double" | "rounded" | "shadow" | "solid"
        },
        language = "en", -- "en" | "sr" currently only only supports English and Serbian
        game_modes = { -- prefered settings for different game modes
            -- type until time expires
            countdown = {
                time = 30,
            },
            -- type until you complete one page
            stopwatch = {
                hide_time = true, -- hide time while typing
            },
            -- NOTE: window height and width will be the same
            rain = {
                throttle = 7, -- increase speed every x seconds
                lives = 3,
            },
        },
    } 
}

return M
