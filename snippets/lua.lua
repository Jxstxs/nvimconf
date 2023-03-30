---@diagnostic disable: undefined-global
return {
    s(
        "snip",
        fmt('{}("{}", fmt({}, {{{}}})),', {
            c(1, {
                t("s"),
                t("sn"),
            }),
            i(2, "trigger"),
            c(3, {
                sn(1, {
                    t('"'),
                    i(1),
                    t('"'),
                }),
                sn(2, {
                    t({ "[[", "" }),
                    i(1),
                    t({ "", "]]" }),
                }),
            }),
            i(4, "'nodes..'"),
        })
    ),
    s(
        "fn",
        fmt( [[
        {}{} = function({})
            {}
        end{}
        ]],
            { c(1, { t("local "), t("") }), i(2, "fnc"), i(3, "args"), i(4, "dave goes here"), i(5) }
        )
    ),

    s("plugin", fmt([[
    {{
        "{}",
        enabled = {},
        event = {{{}}},
        dependencies = {{{}}},
        keys = {{{}}},
        opts = {{{}}},
        config = function()
            {}
        end,
    }},
    ]], {
        i(1, "plugin"),
        c(2, {t("true"), t("false")}),
        i(3, "event"),
        i(4, "deps"),
        i(5, "keys"),
        i(6, "opts"),
        i(7, "setup"),
    })),
}
