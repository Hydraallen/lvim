# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a LunarVim (Neovim distribution) configuration repository. It contains personalized settings, plugins, keybindings, and custom functions for a full-stack development workflow. The configuration is based on LunarVim with influences from jimcornmell and abzcoding's configs.

## Main Configuration Files

| File | Purpose |
|------|---------|
| `config.lua` | Primary LunarVim configuration (~1200 lines): core settings, LSP, Treesitter, 100+ plugins, dashboard, which-key mappings |
| `user.vim` | Custom Vim functions (~740 lines): PushLine(), ShowColours(), ShowChars(), SnippetList(), SnippetEdit(), abbreviations, autocommands |
| `user_keys.vim` | Custom key bindings (~100 lines): buffer navigation, Codeium, dial mappings, snippet shortcuts |
| `user_colors.vim` | Custom color highlights (~50 lines): Zenburn theme modifications, GitSigns colors, cursor highlighting |

## Key Directories

| Directory | Contents |
|-----------|----------|
| `lua/user/` | Lua module configs: `lualine.lua` (status line), `dial.lua` (increment/decrement), `banners.lua` (dashboard ASCII art), `zen.lua`, `todo-comments.lua` |
| `snippets/` | JSON snippet files for 17+ languages (all, ftl, groovy, java, javascript, lua, markdown, python, react-ts, sh, sql, typescript, xml, yaml) |
| `syntax/` | Custom Vim syntax files for specialized formats (auddis, cel, cooptttfile, csv, ecl, edifile, ftl, log4j, runlog, siril) |
| `colors/` | Color schemes: `tokyonight.lua`, `zenburn.vim` |

## Configuration Patterns

### Plugin Management
- Uses lazy.nvim for plugin management
- Plugins defined inline in `config.lua` with lazy loading (events, cmd triggers)
- Lock file: `lua/lazy-lock.json`

### Keybinding Structure
- Leader key: Space (`<space>`)
- Which-key.nvim groups: `z` (toggle display), `j` (dev info), `d` (diagnostics)
- Custom mappings in `user_keys.vim` for buffer navigation, completion, snippets

### LSP Configuration
- Most LSPs auto-configured via mason.nvim
- Custom SQL LSP setup (sqlls) in `config.lua`
- Python DAP configured for debugging

## Notable Custom Features

- **Codeium**: Free Copilot alternative (Tab for suggestions, Alt-Right to accept)
- **Lazygit**: Git TUI (`F8` or `gz`)
- **Ranger**: File explorer (`ra`)
- **Dial.nvim**: Enhanced increment/decrement with custom types (True/False, months, log levels)
- **Snippet system**: Save/edit/list custom snippets (`ss`, `se`, `sl`, `sL`)
- **Custom jump mappings**: `gj` context-aware URL/color/GitHub/ticket jumping
- **Cheatsheet**: Press `F1` to open HTML keybinding reference

## Theme Configuration

Themes available (edit `config.lua` to change):
- `onedark`, `onedark_vivid`, `onedark_dark`, `onelight` (default)
- `zenburn`, `tokyonight`

## Setup Commands

After cloning:
```vim
:LvimUpdate
:LvimCacheReset
:Lazy sync
:LspInstall sqlls
```

## Working With This Config

When modifying:
- Plugin configs → `config.lua` (in the `lvim.plugins` table)
- Key bindings → `user_keys.vim` or `config.lua` (which-key section)
- Custom functions → `user.vim`
- Status line → `lua/user/lualine.lua`
- Colors → `user_colors.vim` or theme files in `colors/`
- Snippets → JSON files in `snippets/`
