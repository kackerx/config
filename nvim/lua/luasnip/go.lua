local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require("luasnip.extras.postfix").postfix

return {
	s("cc", {
		t("ctx context.Context, ")
	}),
	-- err return
	s("c", {
		t("ctx")
	}),

	s("ee", {
		t("err error")
	}),

	s("e", {
		t("if err != nil {"),
		t({ "", "\treturn " }),
		i(1, ""),
		t({ "", "}" }),
	}),

	s("eee", {
		t("; err != nil {"),
		t({ "", "\treturn " }),
		i(1, ""),
		t({ "", "}" }),
	}),

	s("f", {
		t("fmt.Println("),
		i(1),
		t(")"),
	}),

	s("ff", {
		t('fmt.Printf("'),
		i(1),
		t('\\n", '),
		i(2),
		t(")"),
	}),

	s("fi", {
		t("for i := "),
		i(1),
		t("; i < "),
		i(2),
		t({ "; i++ {", "\t" }),
		i(3),
		t({ "", "}" }),
	}),

	s("st", {
		t("type "),
		i(1),
		t({ " struct {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	s("in", {
		t("type "),
		i(1),
		t({ " interface {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	s("fr", {
		t("for "),
		i(2, "_"),
		t(", "),
		i(3, "item"),
		t(" := range "),
		i(1),
		t({ " {", "\t" }),
		i(4),
		t({ "", "}" }),
	}),


	------------------ func node
	s("func", {
		i(1),
		f(
			function(args, snip, user_arg_1)
				return args[1][1]
			end,
			{ 1 },
			{} -- { user_args = { "Will be appended to text from i(0)" } }
		),
		i(0),
	}),

	s("f2", {
		f(function(args, snip)
			return "i got: " .. snip.captures[1]
		end, {}),
	}),

	ls.parser.parse_snippet("newstruct", "func New${1:Struct}() *$1 {\n\treturn &$1{\n\t\t$0\n\t}\n}"),

	------------------ postFix
	postfix(".len", {
		f(function(_, parent)
			return "len(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
		end, {}),
	}),

	postfix(".t", {
		f(function(_, parent)
			return "fmt.Println(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
		end, {}),
	}),

	-- 由lsp代替完成后缀
	-- postfix(".a", { -- 注意这里简化了触发逻辑，根据实际情况调整
	-- 	f(function(_, parent)
	-- 		local match = parent.env.POSTFIX_MATCH
	-- 		return match .. " = append(" .. match .. ", "
	-- 	end, {}),
	-- 	i(1), -- 第一个用户输入点，用于`append`中的值
	-- 	t(")"),
	-- 	i(0) -- 最终的光标位置
	-- })

}
