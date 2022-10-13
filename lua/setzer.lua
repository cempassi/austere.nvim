local M = {}

local function reset()
	vim.api.nvim_command("hi clear")

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.cmd("set termguicolors")
end

local function create_highlight(cmd, pattern, value)
	if value == nil then
		return
	end
	table.insert(cmd, string.format("%s=%s", pattern, value))
end

local function create_link(group, link_to)
	if link_to == nil then
		return
	end

	vim.cmd(string.format([[hi clear %s]], group))
	vim.cmd(string.format([[hi! link %s %s]], group, link_to))
end

function M.setup()
	reset()

	local colors = {
		-- Black
		rich_black = "#0C0C0C",
		dark_eerie_black = "#1A1A1A",
		light_eerie_black = "#262626",
		davys_grey = "#5C5C5C",

		-- Gray
		gray_web = "#7E7E7E",
		quick_silver = "#A5A5A5",
		light_gray = "#CCCCCC",

		-- White
		cultured_white = "#F2F2F2",
		white = "#FFFFFF",

		-- Blue
		baby_blue_eyes = "#B3D5FA",
		dodger_blue = "#4899ea",
		little_boy_blue = "#619EFF",

		-- Yellow
		deep_champagne = "#FFD68A",
		maximum_yellow_red = "#FFCA66",

		-- Red
		light_coral = "#FF7171",

		-- Green
		light_green = "#A6E67E",
	}

	local palette = {
		selection = {
			foreground = colors.rich_black,
			background = colors.baby_blue_eyes,
		},

		background = {
			darkest = colors.rich_black,
			dark = colors.dark_eerie_black,
			dimmed = colors.light_eerie_black,
		},

		foreground = {
			darkest = colors.davys_grey,
			darker = colors.gray_web,
			dimmed = colors.quick_silver,
			medium = colors.light_gray,
			brighter = colors.cultured_white,
			brightest = colors.white,
			green = colors.light_green,
			blue = colors.little_boy_blue,
      yellow = colors.deep_champagne,
		},
	}

	local groups = {
		normal = { fg = palette.foreground.medium, bg = palette.background.darkest },
		selection = { fg = palette.selection.foreground, bg = palette.selection.background },
		parents = { fg = palette.foreground.blue, bg = palette.background.darkest },

		darkest = { fg = palette.foreground.darkest },
		darker = { fg = palette.foreground.darker },
		darker_italic = { fg = palette.foreground.darker, em = "italic" },

		dimmed = { fg = palette.foreground.dimmed },
		dimmed_italic = { fg = palette.foreground.dimmed, em = "italic" },
		dimmed_bold = { fg = palette.foreground.dimmed, em = "bold" },

		medium = { fg = palette.foreground.medium },
		medium_italic = { fg = palette.foreground.medium, em = "italic" },
		medium_underline = { fg = palette.foreground.medium, em = "underline" },

		brighter = { fg = palette.foreground.brighter },
		brighter_italic = { fg = palette.foreground.brighter, em = "italic" },

		brightest = { fg = palette.foreground.brightest, em = "none" },
		brightest_bold = { fg = palette.foreground.brightest, em = "bold" },
		brightest_italic = { fg = palette.foreground.brightest, em = "italic" },
	}

	local hl_groups = {
		Normal = groups.normal,

		Bold = { em = "bold" },
		Italic = { em = "italic" },
		Underlined = { em = "underline" },

		-- Selection
		Visual = groups.selection,

		IncSearch = groups.selection,
		Search = groups.selection,
		Substitute = groups.selection,
		MatchParen = groups.parents,

		Directory = { fg = colors.little_boy_blue },

		ModeMsg = groups.brighter,
		MoreMsg = groups.brighter,
		NonText = { fg = palette.foreground.darkest },

		-- Side Line Numbers
		LineNr = groups.dimmed,
		LineNrAbove = groups.darkest,
		LineNrBelow = groups.darkest,
		CursorLineNr = groups.darker,

		WinSeparator = { fg = palette.foreground.darkest, bg = palette.background.darkest },

		-- Completion Menu
		Pmenu = { fg = palette.foreground.medium, bg = palette.background.dimmed },
		PmenuSel = groups.selection,
		PmenuSbar = { bg = palette.background.brightest },
		WildMenu = { fg = palette.foreground.medium, bg = palette.background.brightest },

		Conceal = groups.darker,
		Title = groups.brighter,
		Question = groups.brighter,
		SpecialKey = groups.darkest,

		-- Folding
		Folded = { fg = palette.foreground.darker, bg = palette.background.dimmed },
		FoldColumn = { fg = palette.foreground.darkest, bg = palette.background.darkest },

		-- Spelling
		SpellBad = { em = "underline" },
		SpellLocal = { em = "underline" },
		SpellCap = { em = "underline" },
		SpellRare = { em = "underline" },

		-- Syntax
		Boolean = groups.brighter,
		Character = groups.brighter,
		Comment = groups.darkest,
		Conditional = groups.dimmed,
		Constant = groups.brighter,
		Define = groups.darker,
		Delimiter = groups.darker,
		Float = groups.brighter,
		Function = groups.dimmed_italic,
		Identifier = groups.medium,
		Include = groups.darker,
		Keyword = groups.dimmed_bold,
		Label = groups.darker,
		Number = groups.brighter,
		Operator = groups.darker,
		PreProc = groups.darker,
		Repeat = groups.darker,
		Special = groups.brighter,
		SpecialChar = groups.brighter,
		Statement = groups.medium,
		StorageClass = groups.brighter,
		String = groups.brightest_italic,
		Structure = groups.brighter,
		Tag = groups.medium,
		Todo = groups.brightest,
		Type = groups.brighter,
		Typedef = groups.brighter,

    -- String
    TSSTring = groups.brightest_italic,
    TSSTringField = groups.medium,
    TSStringSpecial = groups.medium,

    -- Functions and Method
		TSFunction = groups.dimmed_italic,
		TSFuncBuiltin = groups.dimmed_italic,
    TSConstructor = groups.medium_italic,
		TSMethodCall = { link = 'TSFunction' },

		TSPunctBracket = groups.dimmed,

		TSTodo = groups.brightest,

		-- Type
		TSType = groups.medium,
		TSTypeBuiltin = groups.medium,
		TSTypeQualifier = groups.darker_italic,
		TSTypeDefinition = groups.medium,

		-- Variable
		TSField = groups.medium,
		TSVariable = groups.medium,
		TSVariableBuiltin = { fg = palette.foreground.brighter, em = "bold" },

    -- LSP
    DiagnosticHint =  { fg = palette.foreground.blue },
		LspDiagnosticsSignHint = { fg = palette.foreground.blue },
		LspDiagnosticsVirtualTextHint = { fg = palette.foreground.blue },
		LspDiagnosticsFloatingHint = { fg = palette.foreground.blue },
		LspDiagnosticsUnderlineHint = { fg =palette.foreground.blue , em = "undercurl"},

    DiagnosticWarn =  { fg = palette.foreground.yellow },
		LspDiagnosticsSignWarning = { fg = palette.foreground.yellow },
		LspDiagnosticsFloatingWarning = { fg = palette.foreground.yellow },
		LspDiagnosticsVirtualTextWarning = { fg = palette.foreground.yellow },
		LspDiagnosticsUnderlineWarning = {  fg = palette.foreground.yellow , em = "undercurl" },

		-- Git
		DiffAdd = { fg = colors.light_green, bg = palette.background.darkest },
		DiffChange = { fg = colors.maximum_yellow_red, bg = palette.background.darkest },
		DiffDelete = { fg = colors.light_coral, bg = palette.background.darkest },
		DiffText = { fg = colors.dodger_blue, bg = palette.background.darkest },

		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },

		-- Signify
		SignifySignAdd = { link = "DiffAdd" },
		SignifySignChange = { link = "DiffChange" },
		SignifySignDelete = { link = "DiffDelete" },

		-- Floaterm
		NormalFloat = groups.brightest,

		-- LspSaga
		LspSagaDiagnosticBorder = { fg = palette.foreground.brightest },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },

		-- LspInfo
		LspInfoBorder = { fg = palette.foreground.brightest },

		-- Telescope
		TelescopeBorder = groups.brighter,
		TelescopePromptBorder = groups.brighter,
		TelescopeMatching = { fg = colors.light_coral },
		TelescopeSelection = { fg = colors.whight, em = "bold,italic" },
		TelescopeSelectionCaret = groups.brighter,
		TelescopeMultiSelection = { em = "italic" },
		TelescopePreviewHyphen = groups.brighter_italic,
		TelescopeResultsDiffUntracked = {},
	}

	for group, set in pairs(hl_groups) do
		local create = { "hi", group }

		-- Concatenate hi settings for that specific group
		create_highlight(create, "guifg", set.fg)
		create_highlight(create, "guibg", set.bg)
		create_highlight(create, "gui", set.em or "none")
		create_highlight(create, "sp", set.sp)

		-- Create hi group
		vim.cmd(table.concat(create, " "))

		-- Create hi link
		create_link(group, set.link)
	end
end

return M
