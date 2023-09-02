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
}
