-- put user settings here
-- this module will be loaded after everything else when the application starts
-- it will be automatically reloaded when saved

local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"
local common = require "core.common"
-- local command = require "core.command"
-- local widget = require "widget"

-- local litepresence = require "plugins.litepresence"
local fontconfig = require "plugins.fontconfig"

local lsp = require "plugins.lsp"
local lintplus = require "plugins.lintplus"
-- local lspkind = require "plugins.lspkind"

------------------------------ Themes ----------------------------------------

core.reload_module("colors.jellybeans")

--------------------------- Key bindings -------------------------------------

-- key binding:
-- keymap.add { ["ctrl+escape"] = "core:quit" }

keymap.add {
	["alt+up"] = "doc:move-lines-up",
	["alt+down"] = "doc:move-lines-down",
	["ctrl+up"] = "doc:move-to-previous-line",
  ["ctrl+down"] = "doc:move-to-next-line",
}

------------------------------- Fonts ----------------------------------------

fontconfig.use {
	font = { name = 'CartographCF Nerd Font:style=Light', size = 11 },
	code_font = { name = 'CartographCF Nerd Font:style=Light', size = 14 },
}

local italicFont = fontconfig.use {
	font = { name = 'CartpgraphCF Nerd Font:style=Italic', size = 14},

}

style.syntax_fonts["comment"] = renderer.font.load("/home/sid/.local/share/fonts/CartographCF/Cartograph CF Light Italic Nerd Font Complete.otf", 14)
style.syntax_fonts["function"] = renderer.font.load("/home/sid/.local/share/fonts/CartographCF/Cartograph CF Light Italic Nerd Font Complete.otf", 14)


-- customize fonts:
-- style.font = renderer.font.load(DATADIR .. "/fonts/FiraSans-Regular.ttf", 14 * SCALE)
-- style.font = renderer.font.load("/home/sid/.local/share/fonts/CartographCF/Cartograph CF Regular Nerd Font Complete.otf", 11)
-- style.code_font = renderer.font.load("/home/sid/.local/share/fonts/CartographCF/Cartograph CF Regular Nerd Font Complete.otf", 13)
--
-- font names used by lite:
-- style.font          : user interface
-- style.icon_font     : icons
-- style.icon_big_font : toolbar icons
-- style.code_font     : code
-- style.big_font      : big text in welcome screen
--
-- the function to load the font accept a 3rd optional argument like:
-- {antialiasing="grayscale", hinting="full"}
--
-- possible values are:
-- antialiasing: grayscale, subpixel
-- hinting: none, slight, full

style.lint = {
  info = { common.color "#71b9f8" },
  hint = { common.color "#99ad6a" },
  warning = { common.color "#d8ad4c" },
  error = { common.color "#cf6a4c" }
}

------------------------------ Plugins ----------------------------------------

-- enable plugins.trimwhitespace, otherwise it is disable by default:
config.plugins.trimwhitespace = true

-- disable detectindent, otherwise it is enabled by default
config.plugins.detectindent = true
config.tab_type = "hard" -- soft for spaces, hard for real tabs (\t)
config.indent_size = 4   -- 4 spaces

config.plugins.lsp.show_diagnostics = true
config.plugins.lsp.stop_unneeded_servers = true

config.scroll_past_end = false

config.ignore_files = { "%.git$", "^node_modules", "%.lock$" }

config.plugins.minimap = {
  enabled = true,
  width = 75,
  instant_scroll = true,
}

------------------------------ Linters ----------------------------------------

lintplus.load("luacheck")
-- lintplus.setup.lint_on_doc_load()
-- lintplus.setup.lint_on_doc_save()

------------------------------ LSPs ----------------------------------------

lsp.add_server {
  name = "rust-analyzer",
  language = "rust",
  file_patterns = { "%.rs$" },
  command = { 'rust-analyzer' },
  verbose = false
}

lsp.add_server {
  name = "pylsp",
  language = "python",
  file_patterns = { "%.py$" },
  command = { 'pylsp' },
  verbose = false
}

lsp.add_server {
  name = "ccls",
  language = "c/cpp",
  file_patterns = {
    "%.c$", "%.h$", "%.inl$", "%.cpp$", "%.hpp$",
    "%.cc$", "%.C$", "%.cxx$", "%.c++$", "%.hh$",
    "%.H$", "%.hxx$", "%.h++$", "%.objc$", "%.objcpp$"
  },
  command = { "ccls" },
  verbose = true
}

lsp.add_server {
  name = "lua_language_server",
  language = "lua",
  file_patterns = { "%.lua$" },
  command = {
    "lua-language-server",
    "-E",
    "/home/sid/.local/share/lang-servers/lua-language-server/bin/main.lua",
    "-e", "LANG=en",
  },
  -- verbose = true,
  settings = {
    Lua = {
      completion = {
        enable = true,
        -- keywordSnippet = "Disable"
      },
      develop = {
        enable = false,
        debuggerPort = 11412,
        debuggerWait = false
      },
      diagnostics = {
        enable = true,
      },
      hover = {
        enable = true,
        viewNumber = true,
        viewString = true,
        viewStringMax = 1000
      },
      runtime = {
        version = 'Lua 5.4',
        path = {
          "?.lua",
          "?/init.lua",
          "?/?.lua",
          "/usr/share/5.4/?.lua",
          "/usr/share/lua/5.4/?/init.lua"
        }
      },
      signatureHelp = {
        enable = true
      },
      workspace = {
        maxPreload = 2000,
        preloadFileSize = 1000
      }
    }
  },
}
