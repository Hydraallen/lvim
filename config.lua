--[[ Notes: {{{1
Useful Links and TODO
http://cheat.sh
Buffer bar info: https://github.com/romgrk/barbar.nvim
-- }}}1 ]]
--[[ Settings {{{1
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
--]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
lvim.log.level                                      = "warn"
-- keymappings [view all the defaults by pressing <leader>Lk] add your own keymapping
lvim.keys.normal_mode["<C-s>"]                      = ":w<cr>"

lvim.lsp.buffer_mappings.normal_mode['K']           = nil
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- Edit a default keymapping
lvim.keys.normal_mode["<C-q>"]                      = ":wq<cr>"

-- vim options
vim.opt.shiftwidth                                  = 2
vim.opt.tabstop                                     = 2
--vim.opt.relativenumber = true
vim.opt.wrap                                        = true -- wrap lines

lvim.use_icons                                      = true
lvim.format_on_save                                 = false
lvim.auto_complete                                  = true
--lvim.colorscheme                                              = "zenburn"   -- https://github.com/jnurmine/Zenburn
--lvim.colorscheme                                              = "tokyonight"
lvim.auto_close_tree                                = 0
lvim.wrap_lines                                     = true
lvim.timeoutlen                                     = 100
lvim.leader                                         = "space"
lvim.ignore_case                                    = true
lvim.smart_case                                     = true
lvim.termguicolors                                  = true
lvim.vsnip_dir                                      = os.getenv "HOME" .. "/.config/lvim/snippets/"
lvim.builtin.alpha.active                           = true
lvim.builtin.alpha.mode                             = "dashboard"
lvim.builtin.terminal.active                        = true
lvim.builtin.nvimtree.setup.view.side               = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.alpha.active                           = true
lvim.builtin.dap.active                             = true
lvim.builtin.terminal.active                        = true
lvim.builtin.cmp.completion.keyword_length          = 2

-- SQLLS setup. https://github.com/joe-re/sql-language-server
lvim.lsp.automatic_configuration.skipped_servers    = vim.tbl_filter(function(server)
    return server ~= "sqlls"
end, lvim.lsp.automatic_configuration.skipped_servers)

require("lvim.lsp.manager").setup("sqlls", {
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    filetypes = { "sql", "mysql" },
    root_dir = function() return vim.loop.cwd() end,
    -- config = function()
    -- require("user.sqlls").config()
    -- end;
})

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed             = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml"
}

lvim.builtin.treesitter.ignore_install               = { "haskell" }
lvim.builtin.treesitter.highlight.enabled            = true

local iconError                                      = ""
local iconWarn                                       = ""
--local iconHint      = ""
local iconInfo                                       = ""
-- local iconError        = "⛔"
-- local iconWarn         = "⚡"
local iconHint                                       = "⭐"
-- local iconInfo         = "✨"
local iconBar                                        = "▌" -- █ ▉ ▊ ▋ ▌ ▍ ▎ ▏
local iconMark                                       = "◣"
local iconPlus                                       = ""
local iconMinus                                      = ""
local iconExclamation                                = ""

-- To set colours see GitSigns* in ~/.config/lvim/user_colors.vim
lvim.builtin.gitsigns.opts.signs.add.text            = iconBar
lvim.builtin.gitsigns.opts.signs.change.text         = iconBar
lvim.builtin.gitsigns.opts.signs.delete.text         = iconMark
lvim.builtin.gitsigns.opts.signs.topdelete.text      = iconMinus
lvim.builtin.gitsigns.opts.signs.changedelete.text   = iconExclamation

-- To set colours see LspDiagnostics* in ~/.config/lvim/user_colors.vim
-- local config = { -- your config
-- virtual_text = {prefix = '!'} ,
-- signs = lvim.lsp.diagnostics.signs,
-- underline = lvim.lsp.diagnostics.underline,
-- update_in_insert = lvim.lsp.diagnostics.update_in_insert,
-- severity_sort = lvim.lsp.diagnostics.severity_sort,
-- float = lvim.lsp.diagnostics.float,
-- }
-- vim.diagnostic.config(config)

-- lvim.lsp.diagnostics.signs.values = {
-- { name = "DiagnosticSignError",              text = iconError },
-- { name = "DiagnosticSignWarn",               text = iconWarn },
-- { name = "DiagnosticSignInfo",               text = iconInfo },
-- { name = "DiagnosticSignHint",               text = iconHint },
-- }
--}}}


-- Vim config {{{1
vim.cmd('source ~/.config/lvim/user.vim')
vim.cmd('source ~/.config/lvim/lua/user/lualine.lua')
-- }}}1

-- Additional Plugins {{{1
lvim.plugins = {
    -- Zen Mode
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require("user.zen").config()
        end,
    },

    -- SQL LSP.
    -- {
    -- "nanotee/sqls.nvim",
    -- event = "BufRead",
    -- ft = "sql",
    -- config = function()
    -- require("user.sqls").config()
    -- end,
    -- },

    -- Unix commands. Try ":SudoWrite"
    -- Issue with cmp.u.k.recursive appearing when you hit enter.
    -- See: https://github.com/hrsh7th/nvim-cmp/issues/770
    {
        "tpope/vim-eunuch",
        event = "BufRead",
    },

    -- Markers in margin. 'ma' adds marker
    {
        "kshenoy/vim-signature",
        event = "BufRead",
    },

    -- Highlight URL's. http://www.vivaldi.com
    {
        "itchyny/vim-highlighturl",
        event = "BufRead",
    },

    -- Kitty config syntax.  Edit kitty, with vk
    {
        "fladson/vim-kitty",
        event = "BufRead",
        ft = "conf",
    },

    -- Lazygit: Try F8
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
    },

    -- Dev docs
    {
        "rhysd/devdocs.vim"
    },

    -- -----------------------------------------------------------------------
    -- Suggestions from https://www.lunarvim.org/plugins/03-extra-plugins.html
    -- Navigation plugins
    -- hop
    -- neovim motions on speed!
    -- Better motions
    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
        end,
    },

    -- lightspeed
    -- jetpack codebase navigation
    -- {
    --   "ggandor/lightspeed.nvim",
    --   event = "BufRead",
    -- },

    -- minimap
    -- blazing fast minimap/scrollbar written in Rust
    -- {
    --   'wfxr/minimap.vim',
    --   run = "cargo install --locked code-minimap",
    --   -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    --   config = function ()
    --     vim.cmd ("let g:minimap_width = 10")
    --     vim.cmd ("let g:minimap_auto_start = 1")
    --     vim.cmd ("let g:minimap_auto_start_win_enter = 1")
    --   end,
    -- },

    -- numb
    -- jump to the line
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup {
                show_numbers = true, -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            }
        end,
    },

    -- nvim-bqf
    -- better quickfix window
    {
        "kevinhwang91/nvim-bqf",
        event = { "BufRead", "BufNew" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },

    -- nvim-spectre
    -- search and replace
    -- {
    --   "windwp/nvim-spectre",
    --   event = "BufRead",
    --   config = function()
    --     require("spectre").setup()
    --   end,
    -- },

    -- rnvimr
    -- ranger file explorer window
    -- Ranger, Leader r
    {
        "kevinhwang91/rnvimr",
        cmd = "RnvimrToggle",
        --   config = function()
        --     vim.g.rnvimr_draw_border = 1
        --     vim.g.rnvimr_pick_enable = 1
        --     vim.g.rnvimr_bw_enable = 1
        --   end,
    },

    -- snap
    -- fast finder system
    -- {
    --   "camspiers/snap",
    --   rocks = "fzy",
    --   config = function()
    --     local snap = require "snap"
    --     local layout = snap.get("layout").bottom
    --     local file = snap.config.file:with { consumer = "fzy", layout = layout }
    --     local vimgrep = snap.config.vimgrep:with { layout = layout }
    --     snap.register.command("find_files", file { producer = "ripgrep.file" })
    --     snap.register.command("buffers", file { producer = "vim.buffer" })
    --     snap.register.command("oldfiles", file { producer = "vim.oldfile" })
    --     snap.register.command("live_grep", vimgrep {})
    --   end,
    -- },

    -- vim-matchup
    -- navigate and highlight matching words
    -- {
    --   "andymass/vim-matchup",
    --   event = "CursorMoved",
    --   config = function()
    --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
    --   end,
    -- },

    -- Git
    -- diffview
    -- git diff in a single tabpage
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },

    -- git-blame
    -- show git blame
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
            vim.cmd "highlight default link gitblame SpecialComment"
            vim.g.gitblame_enabled = 0
        end,
    },

    -- gitlinker
    -- generate shareable file permalinks for several git web frontend hosts
    -- {
    --   "ruifm/gitlinker.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("gitlinker").setup {
    --       opts = {
    --         -- remote = 'github', -- force the use of a specific remote
    --         -- adds current line nr in the url for normal mode
    --         add_current_line_on_normal_mode = true,
    --         -- callback for what to do with the url
    --         action_callback = require("gitlinker.actions").open_in_browser,
    --         -- print the url after performing the action
    --         print_url = false,
    --         -- mapping to call url generation
    --         mappings = "<leader>gy",
    --       },
    --     }
    --   end,
    --   requires = "nvim-lua/plenary.nvim",
    -- },

    -- octo
    -- edit and review GitHub issues and pull requests
    -- {
    --   "pwntester/octo.nvim",
    --   event = "BufRead",
    -- },

    -- vim-fugitive
    -- git wrapper Try ":Git "
    {
        "tpope/vim-fugitive",
        -- event = "BufRead",
        cmd = {
            "G",
            "Git",
            "Gdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
            "GBrowse",
            "GRemove",
            "GRename",
            "Glgrep",
            "Gedit"
        },
        ft = { "fugitive" }
    },

    -- vim-gist
    -- create/edit Github gists
    -- {
    --   "mattn/vim-gist",
    --   event = "BufRead",
    --   requires = "mattn/webapi-vim",
    -- },

    -- Treesitter
    -- nvim-ts-autotag
    -- autoclose and autorename html tag
    -- {
    --   "windwp/nvim-ts-autotag",
    --   event = "InsertEnter",
    --   config = function()
    --     require("nvim-ts-autotag").setup()
    --   end,
    -- },

    -- nvim-ts-context-commentstring
    -- commentstring option based on the cursor location
    -- {
    --   "JoosepAlviste/nvim-ts-context-commentstring",
    --   event = "BufRead",
    -- },

    -- nvim-ts-rainbow
    -- rainbow parentheses
    -- {
    -- "p00f/nvim-ts-rainbow",
    -- },

    -- playground
    -- view treesitter information
    -- {
    --   "nvim-treesitter/playground",
    --   event = "BufRead",
    -- },

    -- Telescope Extensions
    -- telescope-fzy-native.nvim
    -- fzy style sorter that is compiled
    -- {
    --   "nvim-telescope/telescope-fzy-native.nvim",
    --   run = "make",
    --   event = "BufRead",
    -- },

    -- telescope-project
    -- switch between projects
    -- {
    --   "nvim-telescope/telescope-project.nvim",
    --   event = "BufWinEnter",
    --   setup = function()
    --     vim.cmd [[packadd telescope.nvim]]
    --   end,
    -- },

    -- Colorschemes
    -- lsp-colors
    -- lsp diagnostics highlight groups for non lsp colorschemes
    -- {
    --   "folke/lsp-colors.nvim",
    --   event = "BufRead",
    -- },

    -- lush.nvim
    -- colorscheme creation aid
    -- {
    --   "rktjmp/lush.nvim",
    -- },

    -- nvim-colorizer
    -- color highlighter #ff0000, Blue, #f0f
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, {
                names    = true, -- "Name" codes, see https://www.w3schools.com/colors/colors_hex.asp   Blue, HotPink, OldLace, Plum, LightGreen, Coral
                RGB      = true, -- #RGB hex codes                                                      #f0f #FAB
                RRGGBB   = true, -- #RRGGBB hex codes                                                   #ffff00 #FF00FF
                RRGGBBAA = true, -- #RRGGBBAA hex codes                                                 #ffff00ff #AbCdEf
                rgb_fn   = true, -- CSS rgb() and rgba() functions                                      rgb(100,200,50) rgba(255,255,255,1.0) rgb(100%, 0%, 0%)
                hsl_fn   = true, -- CSS hsl() and hsla() functions                                      hsl(120,100%,50%) hsla(20,100%,40%,0.7)
                css      = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn   = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode     = 'background', -- Set the display mode.
            })
        end,
    },

    -- LSP Enhancement
    -- cmp-tabnine
    -- TabNine completion engine for hrsh7th/nvim-cmp
    {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            local tabnine = require "cmp_tabnine.config"
            tabnine:setup {
                max_lines = 1000,
                max_num_results = 10,
                sort = true,
            }
        end,
        lazy = true,
        event = "InsertEnter",
    },

    -- goto-preview
    -- previewing goto definition calls
    -- {
    --   "rmagatti/goto-preview",
    --   config = function()
    --     require('goto-preview').setup {
    --       width = 120; -- Width of the floating window
    --       height = 25; -- Height of the floating window
    --       default_mappings = false; -- Bind default mappings
    --       debug = false; -- Print debug information
    --       opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
    --       post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
    --       -- You can use "default_mappings = true" setup option
    --       -- Or explicitly set keybindings
    --       -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
    --       -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
    --       -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    --     }
    --   end
    -- },

    -- lsp-rooter
    -- cwd to the project's root directory
    -- {
    --   "ahmedkhalf/lsp-rooter.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp-rooter").setup()
    --   end,
    -- },

    -- lsp_signature.nvim
    -- hint when you type
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".setup()
        end
    },

    -- symbols-outline.nvim - F12
    -- a tree like view for symbols
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
    },

    -- trouble.nvim
    -- diagnostics, references, telescope results, quickfix and location lists
    -- {
    -- "folke/trouble.nvim",
    -- cmd = "TroubleToggle",
    -- },
    -- Also define keybindings in config.lua

    -- lvim.builtin.which_key.mappings["t"] = {
    --   name = "Diagnostics",
    --   t = { "<cmd>TroubleToggle<cr>", "trouble" },
    --   w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    --   d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    --   q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    --   l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    --   r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
    -- },

    -- General
    -- autosave
    -- automatically saving your work whenever you make changes to it
    -- {
    -- "Pocco81/AutoSave.nvim",
    -- config = function()
    -- require("autosave").setup()
    -- end,
    -- },

    -- codi.vim
    -- interactive scratchpad for hackers
    {
        "metakirby5/codi.vim",
        cmd = "Codi",
    },

    -- Enhanced increment/decrement : True, true, January
    -- dial.nvim
    -- extended incrementing/decrementing
    {
        "monaqa/dial.nvim",
        event = "BufRead",
        config = function()
            require("user.dial").config()
        end
    },

    -- glow.nvim
    -- preview markdown in neovim
    -- You must install glow globally
    -- https://github.com/charmbracelet/glow
    -- yay -S glow
    -- {
    -- "npxbr/glow.nvim",
    -- ft = {"markdown"}
    -- run = "yay -S glow"
    -- },

    -- indent-blankline
    -- indentation guides for every line
    -- {
    -- "lukas-reineke/indent-blankline.nvim",
    -- event = "BufRead",
    -- setup = function()
    -- vim.g.indentLine_enabled = 1
    -- vim.g.indent_blankline_char = "▏"
    -- vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
    -- vim.g.indent_blankline_buftype_exclude = {"terminal"}
    -- vim.g.indent_blankline_show_trailing_blankline_indent = false
    -- vim.g.indent_blankline_show_first_indent_level = false
    -- end
    -- },

    -- markdown-preview.nvim
    -- preview markdown in the browser
    -- {
    -- "iamcco/markdown-preview.nvim",
    -- run = "cd app && npm install",
    -- ft = "markdown",
    -- config = function()
    -- vim.g.mkdp_auto_start = 1
    -- end,
    -- },

    -- neoscroll
    -- smooth scrolling
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
                hide_cursor = true,  -- Hide cursor while scrolling
                stop_eof = true,     -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil,      -- Function to run before the scrolling animation starts
                post_hook = nil,     -- Function to run after the scrolling animation ends
            })
        end
    },

    -- neuron
    -- next generation note-taking
    -- {"oberblastmeister/neuron.nvim"},

    -- nvim-lastplace
    -- pick up where you left off
    -- {
    --   "ethanholz/nvim-lastplace",
    --   event = "BufRead",
    --   config = function()
    --     require("nvim-lastplace").setup({
    --       lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    --       lastplace_ignore_filetype = {
    --         "gitcommit", "gitrebase", "svn", "hgcommit",
    --       },
    --       lastplace_open_folds = true,
    --     })
    --   end,
    -- },

    -- persistence
    -- simple session management
    -- {
    --   "folke/persistence.nvim",
    --   event = "BufReadPre", -- this will only start session saving when an actual file was opened
    --   module = "persistence",
    --   config = function()
    --     require("persistence").setup {
    --       dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
    --       options = { "buffers", "curdir", "tabpages", "winsize" },
    --     }
    --   end,
    -- },

    -- Also define keybindings in your config.lua
    -- lvim.builtin.which_key.mappings["S"]= {
    --   name = "Session",
    --   c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    --   l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    --   Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    -- },

    -- todo-comments.nvim
    -- highlight and search for todo comments
    -- FIX:Something to describe.
    -- FIXJCO:Something to describe.
    -- FIXJC:Something to describe.
    -- FIXME: Something to describe.
    -- BUG:Something to describe.
    -- FIXIT: Something to describe.
    -- ISSUE: Something to describe.
    -- TODO:Something to describe.
    -- HACK:Something to describe.
    -- WARN:Something to describe.
    -- WARNING:Something to describe.
    -- XXX:Something to describe.
    -- PERF:Something to describe.
    -- OPTIM:Something to describe.
    -- PERFORMANCE:Something to describe.
    -- OPTIMIZE:Something to describe.
    -- NOTE:Something to describe.
    -- INFO:Something to describe.
    -- TEST: Test something.
    -- OK: Something.
    -- ISH: Something.
    -- BAD: Something.
    -- :TodoQuickFix
    -- :TodoTelescope
    -- :TodoTrouble
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        -- requires = "nvim-lua/plenary.nvim",
        config = function()
            require("user.todo-comments").config()
        end,
    },

    -- vim-cursorword
    -- underlines the word under the cursor
    -- {
    --   "itchyny/vim-cursorword",
    --   event = {"BufEnter", "BufNewFile"},
    --   config = function()
    --     vim.api.nvim_command("augroup user_plugin_cursorword")
    --     vim.api.nvim_command("autocmd!")
    --     vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
    --     vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
    --     vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
    --     vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
    --     vim.api.nvim_command("augroup END")
    --   end
    -- },

    -- vim-repeat
    -- enable repeating supported plugin maps with "."
    { "tpope/vim-repeat" },

    -- vim-sanegx
    -- open url with gx
    {
        "felipec/vim-sanegx",
        event = "BufRead",
    },

    -- vim-surround
    -- mappings to delete, change and add surroundings
    -- Surroundings.  Try cs"'  in a string "with double quotes" to convert to single.
    {
        "tpope/vim-surround",
        -- event = "BufRead",
        --   keys = {"c", "d", "y"}
    },

    -- vim-wakatime
    -- metrics, insights, and time tracking automatically generated from your programming activity
    {
        "wakatime/vim-wakatime"
    },
    -- Once installed and synced, add your WakaTime API Key via :WakaTimeApiKey command

    -- Language specific
    -- bracey
    -- live edit html, css, and javascript
    -- {
    --   "turbio/bracey.vim",
    --   cmd = {"Bracey", "BracyStop", "BraceyReload", "BraceyEval"},
    --   run = "npm install --prefix server",
    -- },


    -- Vim syntax file for Docker's Dockerfile and snippets for snipMate.
    {
        'ekalinin/Dockerfile.vim'
    },

    -- Codeium completion...
    {
        'Exafunction/codeium.vim'
    },

    -- vim-bundler
    -- lightweight support for ruby's bundler
    -- {
    --   "tpope/vim-bundler",
    --   cmd = {"Bundler", "Bopen", "Bsplit", "Btabedit"}
    -- },

    -- vim-rails
    -- edit ruby on rails applications
    -- {
    --   "tpope/vim-rails",
    --   cmd = {
    --     "Eview",
    --     "Econtroller",
    --     "Emodel",
    --     "Smodel",
    --     "Sview",
    --     "Scontroller",
    --     "Vmodel",
    --     "Vview",
    --     "Vcontroller",
    --     "Tmodel",
    --     "Tview",
    --     "Tcontroller",
    --     "Rails",
    --     "Generate",
    --     "Runner",
    --     "Extract"
    --   }
    -- }
}
-- }}}1

-- Autocommands (https://neovim.io/doc/user/autocmd.html) {{{1
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
-- }}}1

-- Additional Leader bindings for WhichKey and key mappings {{{1
-- lvim.builtin.which_key.mappings["r"] = {
-- "<cmd>RnvimrToggle<CR>",                             "Ranger"
-- }

lvim.builtin.which_key.mappings["z"] = {
    "<cmd>ZenMode<CR>:set nospell<CR>", "Zen Mode"
}

lvim.builtin.which_key.mappings["t"] = {
    name = "Toggle Display Options",
    a = { ":call ToggleAll()<CR>", "Toggle All" },
    b = { ":call ToggleColourGitBlame()<CR>", "Toggle git Blame line visibility" },
    c = { ":call ToggleColourCursorColumn()<CR>", "Toggle cursor Column visibility" },
    e = { ":call ToggleColourWhiteSpaceAtEndOfLine()<CR>", "Toggle whitespace at End of line visibility" },
    g = { ":call ToggleGutter()<CR>", "Toggle left Gutter" },
    h = { ":ColorizerToggle<CR>", "Toggle Hex colour and colour name matches" },
    i = { ":call ToggleColourIncSearch()<CR>", "Toggle hIghlight matching words under cursor" },
    l = { ":call ToggleColourCursorLine()<CR>", "Toggle cursor Line visibility" },
    m = { ":call ToggleMarkerLines()<CR>", "Toggle Marker lines" },
    r = { ":set wrap!<CR>", "Toggle line wRap" },
    s = { ":set spell!<CR>", "Toggle Spell checking" },
    t = { ":call ToggleColourLineTooLong()<CR>", "Toggle line Too long highlighting" },
    w = { ":set list!<CR>", "Toggle Whitespace visibility" },
    y = { ":call ToggleColourSyntax()<CR>", "Toggle sYntax highlighting" }
}
lvim.builtin.which_key.mappings["j"] = {
    name = "Show/Jump various dev info",
    a = { ":silent exec '!jump Artifact %:p:h'<CR>", "Jump Artifactory (project)" },
    c = { ":silent exec '!jump Ci %:p:h'<CR>", "Jump Ci (project)" },
    h = { ":call OpenHelpPage()<CR>", "Jump vim Help page for word under cursor" },
    i = { ":silent exec '!jump Live %:p:h'<CR>", "Jump lIve (project)" },
    j = { ":call JumpToSelection()<CR>", "Jump to url or hex color or git etc" },
    l = { ":silent exec '!jump Lint %:p:h'<CR>", "Jump Lint (project)" },
    m = { ":<C-U>exe 'Man' v:count '<C-R><C-W>'<CR>", "Jump linux Man page for word under cursor" },
    n = { ":silent exec '!jump Notes %:p:h'<CR>", "Jump Notes (project search in confluence)" },
    r = { ":silent exec '!jump Repo %:p:h'<CR>", "Jump Repo (git or bitbucket)" },
    s = { ":call ShowJira()<CR>", "Show jira ticket in new buffer" },
    t = { ":silent exec '!jump Ticket %:p:h'<CR>", "Jump jira Ticket in browser" },
    u = { ":silent exec '!jump TestReports %:p:h'<CR>", "Jump Unit test reports" }
}
lvim.builtin.which_key.mappings["d"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<CR>", "trouble" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<CR>", "document" },
    q = { "<cmd>TroubleToggle quickfix<CR>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<CR>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<CR>", "references" },
}

vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<TAB>",   ":BufferNext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-l>",   ":BufferNext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-h>",   ":BufferPrevious<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-x>",   ":BufferClose<CR>", { noremap = true, silent = true })

-- }}}1

-- Load my snippets {{{1
-- See ~/.config/lvim/snippets/package.json
-- And this site to make snippets: https://snippet-generator.app
-- For variables see: https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variables
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets" } }
-- }}}1

local dap = require('dap')

dap.adapters.python = {
    type = 'executable',
    command = "python3",
    args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = dap.configurations.python or {}
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'launch with options',
    program = '${file}',
    python = function()
    end,
    pythonPath = function()
        local path
        for _, server in pairs(vim.lsp.buf_get_clients()) do
            path = vim.tbl_get(server, 'config', 'settings', 'python', 'pythonPath')
            if path then break end
        end
        path = vim.fn.input('Python path: ', path or '', 'file')
        return path ~= '' and vim.fn.expand(path) or nil
    end,
    args = function()
        local args = {}
        local i = 1
        while true do
            local arg = vim.fn.input("Argument [" .. i .. "]: ")
            if arg == '' then
                break
            end
            args[i] = arg
            i = i + 1
        end
        return args
    end,
    justMyCode = function()
        return vim.fn.input('justMyCode? [y/n]: ') == 'y'
    end,
    stopOnEntry = function()
        return vim.fn.input('justMyCode? [y/n]: ') == 'y'
    end,
    console = 'integratedTerminal'
})

-- Dashboard/Alpha {{{1

lvim.builtin.alpha.dashboard.section.header.opts.hl  = ""
-- Shorter ASCII art logo, so not too much space is taken up.
-- 随机选择标题的函数
local function getRandomHeader()
    math.randomseed(os.time())
    local headers = {
      {
      "                              ",
      "⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢦⠙⢿⣿⣿⣿⣿⣿⣿⣿",
      "⣿⣿⣿⣿⢯⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⠛⢿⣿⣿⣿⣿⣿",
      "⣿⣿⣿⢧⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡕⠂⠈⢻⣿⣿⣿⣿",
      "⣿⣿⡅⣻⡿⢿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠿⢿⣿⡇⠀⠀⠈⣿⣿⣿⣿",
      "⣿⣿⠀⠀⠀⠘⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⣹⣿⣿⣿",
      "⣿⣿⠀⠀⠀⠀⣿⣿⡿⠿⠛⠻⣿⣿⣿⣿⡿⠟⠁⠈⠀⠉⠻⡆⠀⠀⠀⣿⣿⣿",
      "⣿⣯⠄⠂⠀⠀⣿⡋⠀⢀⠀⠀⠀⠉⣿⣿⡀⠀⠀⠘⠓⣠⣶⣿⡀⠀⠀⠘⣿⣿",
      "⣿⣫⡆⠀⠀⢀⣿⣷⣶⣄⠀⢀⣤⣴⣿⣿⣿⣶⣄⠀⣴⣿⣿⣿⠁⠀⠀⠀⠘⣿",
      "⣿⣿⠁⠀⠀⡤⠙⢿⣿⣿⣷⣾⣿⡿⣿⣿⢿⠿⣿⣧⣿⣿⡿⢣⠀⠀⠀⠀⢠⣿",
      "⣷⣌⠈⠀⠀⠀⠀⣆⠈⡉⢹⣿⣿⣆⡀⠀⠀⢠⣿⣿⣿⡿⢃⣼⠀⠀⠀⠀⣸⣿",
      "⣿⣿⡇⠀⠀⠀⠀⠙⢿⣿⣆⠈⠛⠛⠛⠀⠀⠈⠉⠁⠀⢠⣿⠇⠀⠀⠀⠹⢿⡇",
      "⣿⡫⠀⠀⠁⠀⠀⠀⠈⠻⣿⢢⣄⠀⠀⠀⠀⠀⣀⣠⣾⡾⠋⠀⠀⠀⠀⢀⠴⠋",
      "⣿⣁⠄⠀⠀⠀⣀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⠿⡿⠋⠀⠀⠀⠀⠀⣀⠬⠆⢀",
      "⣿⣿⣧⣄⠀⠀⠉⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠠⠙",
      "                              ",
    },
    {
      [[                                                ]],
      [[                                          _.oo. ]],
      [[                  _-u[[/;:,.         .odMMMMMM' ]],
      [[               .o888UU[[[/;:-.. .o@P^    MMM^   ]],
      [[              oN88888UU[[[/;::-..       dP^     ]],
      [[             dNMMNN888UU[[[/;:--..  .o@P^       ]],
      [[            ,MMMMMMN888UU[[/;::-..o@^           ]],
      [[            NNMMMNN888UU[[[/~.o@P^              ]],
      [[            888888888UU[[[/o@^-...              ]],
      [[           oI8888UU[[[/o@P^:--....              ]],
      [[        .@^  YUU[[[/o@^;::---....               ]],
      [[      oMP     ^/o@P^;:::---....                 ]],
      [[   .dMMM    .o@^ ^;::---.....                   ]],
      [[  dMMMMMMM@^`       `^^^^^                      ]],
      [[ YMMMUP^                                        ]],
      [[                                                ]],
      [[                                                ]],
      [[                                                ]],
    },
    {
      [[]],
      [[]],
      [[░█████╗░██████╗░░█████╗░░█████╗░███╗░░██╗███████╗]],
      [[██╔══██╗██╔══██╗██╔══██╗██╔══██╗████╗░██║██╔════╝]],
      [[███████║██████╔╝██║░░╚═╝███████║██╔██╗██║█████╗░░]],
      [[██╔══██║██╔══██╗██║░░██╗██╔══██║██║╚████║██╔══╝░░]],
      [[██║░░██║██║░░██║╚█████╔╝██║░░██║██║░╚███║███████╗]],
      [[╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝]],
      [[]],
      [[]],
    },
    {
      [[    .                             .                                 .]],
      [[ .                o88888888888888  d88b  .  8888888b.  .             ]],
      [[          .  .    Y88<""""888"""" j8PY8i    888   )88                ]],
      [[                   Y8b.   888    ,8P  Y8,   88888888'         .      ]],
      [[____________________>88b  888    88888888   888  Y8b_________________]],
      [[::::::::::::88888888888P  888   d8P    Y8b  888   Y888888::::::::::::]],
      [[::::::::::::(                                           )::::::::::::]],
      [[::::::::::::Y8b  d88b  d8P  d88b   . 8888888b.  o88888888::::::::::::]],
      [["""""""""""""88ij8888ij88' j8PY8i    888   )88  Y88<"""""""""""""""""]],
      [[             "8888PY8888' ,8P  Y8,   88888888'   Y8b.   .            ]],
      [[    .         Y88P  Y88P  88888888   888  Y8b_____>88b              .]],
      [[  .         .  Y8'  "8P  d8P    Y8b  888   Y888888888P               ]],
      [[]],
    },

    {
      [[ =ccccc,      ,cccc       ccccc      ,cccc,  ?$$$$$$$,  ,ccc,   -ccc        ]],
      [[:::"$$$$bc    $$$$$     ::`$$$$$c,  : $$$$$c`:"$$$$???'`."$$$$c,:`?$$c      ]],
      [[`::::"?$$$$c,z$$$$F     `:: ?$$$$$c,`:`$$$$$h`:`?$$$,` :::`$$$$$$c,"$$h,    ]],
      [[  `::::."$$$$$$$$$'    ..,,,:"$$$$$$h, ?$$$$$$c`:"$$$$$$$b':"$$$$$$$$$$$c   ]],
      [[     `::::"?$$$$$$    :"$$$$c:`$$$$$$$$d$$$P$$$b`:`?$$$c : ::`?$$c "?$$$$h, ]],
      [[       `:::.$$$$$$$c,`::`????":`?$$$E"?$$$$h ?$$$.`:?$$$h..,,,:"$$$,:."?$$$c]],
      [[         `: $$$$$$$$$c, ::``  :::"$$$b `"$$$ :"$$$b`:`?$$$$$$$c``?$F `:: "::]],
      [[          .,$$$$$"?$$$$$c,    `:::"$$$$.::"$.:: ?$$$.:.???????" `:::  ` ``` ]],
      [[          'J$$$$P'::"?$$$$h,   `:::`?$$$c`::``:: .:: : :::::''   `          ]],
      [[         :,$$$$$':::::`?$$$$$c,  ::: "::  ::  ` ::'   ``                    ]],
      [[        .'J$$$$F  `::::: .::::    ` :::'  `                                 ]],
      [[       .: ???):     `:: :::::                                               ]],
      [[       : :::::'        `                                                    ]],
      [[        ``                                                                  ]],
    },

    {
      [[]],
      [[         _nnnn_                      ]],
      [[        dGGGGMMb     ,"""""""""""""".]],
      [[       @p~qp~~qMb    | Linux Rules! |]],
      [[       M|@||@) M|   _;..............']],
      [[       @,----.JM| -'                 ]],
      [[      JS^\__/  qKL                   ]],
      [[     dZP        qKRb                 ]],
      [[    dZP          qKKb                ]],
      [[   fZP            SMMb               ]],
      [[   HZM            MMMM               ]],
      [[   FqM            MMMM               ]],
      [[ __| ".        |\dS"qML              ]],
      [[ |    `.       | `' \Zq              ]],
      [[_)      \.___.,|     .'              ]],
      [[\____   )MMMMMM|   .'                ]],
      [[     `-'       `--' hjm              ]],
      [[]],
    },
    {
      [[           _____________________________________________        ]],
      [[         //:::::::::::::::::::::::::::::::::::::::::::::\\      ]],
      [[       //:::_______:::::::::________::::::::::_____:::::::\\    ]],
      [[     //:::_/   _-"":::_--"""        """--_::::\_  ):::::::::\\  ]],
      [[    //:::/    /:::::_"                    "-_:::\/:::::|^\:::\\ ]],
      [[   //:::/   /~::::::I__                      \:::::::::|  \:::\\]],
      [[   \\:::\   (::::::::::""""---___________     "--------"  /::://]],
      [[    \\:::\  |::::::::::::::::::::::::::::""""==____      /:::// ]],
      [[     \\:::"\/::::::::::::::::::::::::::::::::::::::\   /~::://  ]],
      [[       \\:::::::::::::::::::::::::::::::::::::::::::)/~::://    ]],
      [[         \\::::\""""""------_____::::::::::::::::::::::://      ]],
      [[           \\:::"\               """""-----_____:::::://        ]],
      [[             \\:::"\    __----__                )::://          ]],
      [[               \\:::"\/~::::::::~\_         __/~:://            ]],
      [[                 \\::::::::::::::::""----""":::://              ]],
      [[                   \\::::::::::::::::::::::::://                ]],
      [[                     \\:::\^""--._.--""^/::://                  ]],
      [[                       \\::"\         /":://                    ]],
      [[                         \\::"\     /":://                      ]],
      [[                           \\::"\_/":://                        ]],
      [[                             \\::::://                          ]],
      [[                               \\_//                            ]],
    },
    {
      [[_____________________                              _____________________ ]],
      [[`-._:  .:'   `:::  .:\           |\__/|           /::  .:'   `:::  .:.-' ]],
      [[    \      :          \          |:   |          /         :       /     ]],
      [[     \     ::    .     `-_______/ ::   \_______-'   .      ::   . /      ]],
      [[      |  :   :: ::'  :   :: ::'  :   :: ::'      :: ::'  :   :: :|       ]],
      [[      |     ;::         ;::         ;::         ;::         ;::  |       ]],
      [[      |  .:'   `:::  .:'   `:::  .:'   `:::  .:'   `:::  .:'   `:|       ]],
      [[      /     :           :           :           :           :    \       ]],
      [[     /______::_____     ::    .     ::    .     ::   _____._::____\      ]],
      [[                   `----._:: ::'  :   :: ::'  _.----'                    ]],
      [[                          `--.       ;::  .--'                           ]],
      [[                              `-. .:'  .-'                               ]],
      [[                                 \    / :F_P:                            ]],
      [[                                  \  /                                   ]],
      [[                                   \/                                    ]],
      [[]],
    },
    {
      [[                    _wr""        "-q__                    ]],
      [[                 _dP                 9m_                  ]],
      [[               _#P                     9#_                ]],
      [[              d#@                       9#m               ]],
      [[             d##                         ###              ]],
      [[            J###                         ###L             ]],
      [[            {###K                       J###K             ]],
      [[            ]####K      ___aaa___      J####F             ]],
      [[        __gmM######_  w#P""   ""9#m  _d#####Mmw__         ]],
      [[     _g##############mZ_         __g##############m_      ]],
      [[   _d####M@PPPP@@M#######Mmp gm#########@@PPP9@M####m_    ]],
      [[  a###""          ,Z"#####@" '######"\g          ""M##m   ]],
      [[ J#@"             0L  "*##     ##@"  J#              *#K  ]],
      [[ #"               `#    "_gmwgm_~    dF               `#_ ]],
      [[7F                 "#_   ]#####F   _dK                 JE ]],
      [[]                    *m__ ##### __g@"                   F ]],
      [[                       "PJ#####LP"                        ]],
      [[ `                       0######_                      '  ]],
      [[                       _0########_                        ]],
      [[     .               _d#####^#####m__              ,      ]],
      [[      "*w_________am#####P"   ~9#####mw_________w*"       ]],
      [[          ""9@#####@M""           ""P@#####@M""           ]],
    },
    {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣾⠿⠿⠟⠛⠛⠛⠛⠿⠿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠂⠉⠉⠉⠉⢩⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⢰⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⡀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⢀⣸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡧⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠈⠁⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠉⠢⠤⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡟⠈⠑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠒⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⢀⣣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠒⠢⠤⠄⣀⣀⠀⠀⠀⢠⣿⡟⠀⠀⠀⣺⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⣿⠇⠀⠀⠀⠀⠀⣤⡄⠀⠀⢠⣤⡄⠀⢨⣭⣠⣤⣤⣤⡀⠀⠀⢀⣤⣤⣤⣤⡄⠀⠀⠀⣤⣄⣤⣤⣤⠀⠀⣿⣯⠉⠉⣿⡟⠀⠈⢩⣭⣤⣤⠀⠀⠀⠀⣠⣤⣤⣤⣄⣤⣤",
      "⢠⣿⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⣸⣿⠁⠀⣿⣿⠉⠀⠈⣿⡇⠀⠀⠛⠋⠀⠀⢹⣿⠀⠀⠀⣿⠏⠀⠸⠿⠃⠀⣿⣿⠀⣰⡟⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⣿⡟⢸⣿⡇⢀⣿",
      "⣸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⣿⡟⠀⢠⣿⡇⠀⠀⢰⣿⡇⠀⣰⣾⠟⠛⠛⣻⡇⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⢻⣿⢰⣿⠀⠀⠀⠀⠀⠀⣾⡇⠀⠀⠀⢸⣿⠇⢸⣿⠀⢸⡏",
      "⣿⣧⣤⣤⣤⡄⠀⠘⣿⣤⣤⡤⣿⠇⠀⢸⣿⠁⠀⠀⣼⣿⠀⠀⢿⣿⣤⣤⠔⣿⠃⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⠋⠀⠀⠀⢠⣤⣤⣿⣥⣤⡄⠀⣼⣿⠀⣸⡏⠀⣿⠃",
      "⠉⠉⠉⠉⠉⠁⠀⠀⠈⠉⠉⠀⠉⠀⠀⠈⠉⠀⠀⠀⠉⠉⠀⠀⠀⠉⠉⠁⠈⠉⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠉⠁⠀⠉⠁⠀⠉⠀",
    },
    }
    local randomIndex = math.random(1, #headers)
    return headers[randomIndex]
end

-- 设置标题
lvim.builtin.alpha.dashboard.section.header.val = getRandomHeader()


lvim.builtin.alpha.dashboard.section.buttons.entries = {
    { "SPC f", "🔎 Find File",           "<CMD>Telescope find_files<CR>" },
    { "SPC n", "✍🏻️New File",            "<CMD>ene!<CR>" },
    { "SPC p", "  Recent Projects ",    "<CMD>Telescope projects<CR>" },
    { "SPC u", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    -- { "SPC s",   "  Load last session",           "<CMD>SessionLoad<CR>" },
    { "SPC r", "  Ranger",              "<CMD>RnvimrToggle<CR>" },
    { "SPC m", "  Marks              ", "<CMD>Telescope marks<CR>" },
    { "SPC w", "  Find Word",           "<CMD>Telescope live_grep<CR>" },
    { "SPC c", "  Edit Configuration",  "<CMD>e ~/bin/config/configFiles.md<CR>" },
    { "SPC g", "  Git status",          "<CMD>Telescope git_status<CR>" }
}
--}}}


-- See end of this file for my other config.
--    ~/.local/share/lunarvim/lvim/init.lua
-- It has two lines added:
vim.cmd('source ~/.config/lvim/user_colors.vim')
vim.cmd('source ~/.config/lvim/user_keys.vim')

-- HACK: Link in the style so the background is correct.
-- lvim.builtin.lualine.options.theme                  = "curvywurvy"
--     ln -s ~/.config/lvim/lua/user/lualine-curvywurvy-theme.lua ~/.local/share/lunarvim/site/pack/lazy/opt/lualine.nvim/lua/lualine/themes/curvywurvy.lua
