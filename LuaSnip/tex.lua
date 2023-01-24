-- https://www.ejmastnak.com/tutorials/vim-latex/luasnip.html
return {
	s("tt", { t("\\texttt{"), i(1), t("}") }),
	s({ trig = ";a", snippetType = "autosnippet" }, { t("\\alpha") }),
	s({ trig = ";b", snippetType = "autosnippet" }, { t("\\beta") }),
	s({ trig = ";t", snippetType = "autosnippet" }, { t("\\theta") }),
	s("begin", { t("\\begin{"), i(1), t({ "}", "\\end{" }), i(1), t("}") }),
	s({ trig = "eq", dscr = "A LaTeX equation environment" }, {
		fmta(
			[[
        \begin{equation}
            <>
        \end{equation}
    ]],
			{ i(1) },
			{ delimiters = "<>" }
		),
	}),
}
