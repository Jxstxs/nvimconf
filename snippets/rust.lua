---@diagnostic disable: undefined-global
return {
    s("match", fmt("match {} {{}}", { i(1, "var") })),

    s(
        "let",
        fmt("let {} = {};", {
            c(1, {
                sn(1, fmt("{}", { i(1, "name") })),
                sn(2, fmt("{}: {}", { i(1, "name"), i(2, "type") })),
            }),
            i(2, "value"),
        })
    ),

    s( "if", fmt( "{}", {
                c(1, {
                    sn( 1, fmt( [[
        if {} {{
            {}
        }}
        ]], { i(1, "statement"), i(2, "code"), })),
                    sn(2, fmt("if {} {{ {} }} else {{ {} }}", { i(1, "cond"), i(2, "value"), i(3, "value") })),
                }),
            }
        )
    ),

    s("else", fmt([[
else{}{{
    {}
}}
    ]], {c(1, {
        t(" "),
sn(1, fmt(" if {} ", {i(1, "cond")})),
    }), i(2, "code")})),
}
