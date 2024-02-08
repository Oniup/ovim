local M = {}

local u = require("core.utils")

local function button(sc, icon, txt, keybind, keybind_opts)
    local leader = "SPC"
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")
    local opts = {
        position = "center",
        hl = "Keyword",
        shortcut = sc,
        cursor = 3,
        width = 25,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = u.map_tbl({ noremap = true, silent = true, nowait = true }, keybind_opts)
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end
    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end
    local count = (opts.width - string.len(txt)) / 2
    txt = icon .. string.rep(" ", count) .. txt
    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

-- https://texteditor.com/ascii-art/
-- http://www.patorjk.com/software/taag/#p=display&f=Graffiti&t=Neovim
M.header_using = 1
M.headers = {
    {
        txt = {
            [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
            [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
            [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
            [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
            [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
            [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
            [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
            [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
            [[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
            [[                                ░                  ]],
        },
        div = 2.5,
        top = true,
    },
    {
        txt = {
            [[ __  __                                             ]],
            [[/\ \/\ \                          __                ]],
            [[\ \ `\\ \     __    ___   __  __ /\_\    ___ ___    ]],
            [[ \ \ , ` \  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
            [[  \ \ \`\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        },
    },
    {
        txt = {
            [[ _   _                 _           ]],
            [[| \ | |               (_)          ]],
            [[|  \| | ___  _____   ___ _ __ ___  ]],
            [[| . ` |/ _ \/ _ \ \ / / | '_ ` _ \ ]],
            [[| |\  |  __/ (_) \ V /| | | | | | |]],
            [[\_| \_/\___|\___/ \_/ |_|_| |_| |_|]],
        },
    },
    {
        txt = {
            [[  _  _                              _            ]],
            [[ | \| |    ___     ___    __ __    (_)    _ __   ]],
            [[ | .` |   / -_)   / _ \   \ V /    | |   | '  \  ]],
            [[ |_|\_|   \___|   \___/   _\_/_   _|_|_  |_|_|_| ]],
            [[_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| ]],
            [["`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' ]],
        },
    },
    {
        txt = {
            [[         ,--.                                                        ]],
            [[       ,--.'|                                                 ____   ]],
            [[   ,--,:  : |                                ,--,           ,'  , `. ]],
            [[,`--.'`|  ' :             ,---.            ,--.'|        ,-+-,.' _ | ]],
            [[|   :  :  | |            '   ,'\      .---.|  |,      ,-+-. ;   , || ]],
            [[:   |   \ | :   ,---.   /   /   |   /.  ./|`--'_     ,--.'|'   |  || ]],
            [[|   : '  '; |  /     \ .   ; ,. : .-' . ' |,' ,'|   |   |  ,', |  |, ]],
            [['   ' ;.    ; /    /  |'   | |: :/___/ \: |'  | |   |   | /  | |--'  ]],
            [[|   | | \   |.    ' / |'   | .; :.   \  ' .|  | :   |   : |  | ,     ]],
            [['   : |  ; .''   ;   /||   :    | \   \   ''  : |__ |   : |  |/      ]],
            [[|   | '`--'  '   |  / | \   \  /   \   \   |  | '.'||   | |`-'       ]],
            [['   : |      |   :    |  `----'     \   \ |;  :    ;|   ;/           ]],
            [[;   |.'       \   \  /               '---" |  ,   / '---'            ]],
            [['---'          `----'                       ---`-'                   ]],
        },
        top = true,
    },
    {
        txt = {
            [[ ▐ ▄ ▄▄▄ .       ▌ ▐· ▄ • ▌ ▄ ·. ]],
            [[•█▌▐ ▀▄.▀· ▄█▀▄ ▪█·█▌▪  ·██ ▐███▪]],
            [[▐█▐▐▌▐▀▀▪▄▐█▌.▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·]],
            [[██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌]],
            [[▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀ ▀▀  █▪▀▀▀]],
        },
        div = 2,
    },
}

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = M.headers[M.header_using].txt
dashboard.section.header.opts.hl = "Title"

local v = vim.version()
local v_str = "v" .. table.concat({ v.major, v.minor, v.patch }, ".")
local rep_count = string.len(dashboard.section.header.val[1]) - string.len(v_str)
if M.headers[M.header_using].div then
    rep_count = rep_count / M.headers[M.header_using].div
end
local pos = 1
if not M.headers[M.header_using].top then
    pos = #dashboard.section.header.val + 1
end
table.insert(dashboard.section.header.val, pos, string.rep(" ", rep_count) .. v_str)

dashboard.config.opts.noautocmd = true
dashboard.button = button

dashboard.section.buttons.val = {
}

vim.cmd([[autocmd User AlphaReady echo 'ready']])

M.opts = dashboard.config

return M
