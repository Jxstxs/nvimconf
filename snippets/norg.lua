---@diagnostic disable: undefined-global
return {
    s("ttdt", fmt([[
    * Things To Do Today
    {}
    ]], {i(1, "Todo")})),

    s("def", fmt("{}", {c(1, {
        sn(1, fmt([[
        $ {}
        {}
        ]], {i(1, "Term"), i(2, "Definition")})),
        sn(2, fmt([[
        $$ {}
        {}
        $$
        ]], {i(1, "Term"), i(2, "Definition")})),
    })})),

    s("fnote", fmt("{}", {c(1, {
        sn(1, fmt([[ ^ {} ]], {i(1, "Footnote")})),
        sn(2, fmt([[
        ^^ {}
        ^^
        ]], {i(1, "Footnote")})),
    })})),

    s("group", fmt([[
    |{}
    {}
    |
    ]], {i(1, "group"), i(2, "content")})),

    s("code", fmt([[
    @code {}
    {}
    @end
    ]], {i(1, "land"), i(2, "code")})),

    s("heading", fmt("{} {}", {c(1, {
        t("*"),
        t("**"),
        t("***"),
        t("****"),
        t("*****"),
        t("******"),
    }), c(2, {
        i(1, "heading"),
        sn(2, fmt("( ) {}", {i(1, "heading")})),
    })})),

    s("ulist", fmt("{} {}", {c(1, {
        t("-"),
        t("--"),
        t("---"),
        t("----"),
        t("-----"),
        t("------"),
    }), c(2, {
        i(1, "item"),
        sn(2, fmt("( ) {}", {i(1, "item")})),
    })})),

    s("olist", fmt("{} {}", {c(1, {
        t("~"),
        t("~~"),
        t("~~~"),
        t("~~~~"),
        t("~~~~~"),
        t("~~~~~~"),
    }), c(2, {
        i(1, "item"),
        sn(2, fmt("( ) {}", {i(1, "item")})),
    })})),

    s("qoute", fmt("{} {}", {c(1, {
        t(">"),
        t(">>"),
        t(">>>"),
        t(">>>>"),
        t(">>>>>"),
        t(">>>>>>"),
    }), i(2, "item")})),

    s("link", fmt("{{# {}}}{}", {i(1, "link"), c(2, {
        t(""),
        sn(2, fmt("[{}]", {i(1, "title")})),
    })})),

    s("todo", fmt("({}) {}", {i(1, ""), i(2, "Todo")})),

    s("context", fmt("#context {}", {i(1, "cnt")})),

    -- s("proj", fmt([[ #context {} * ( ) {} {} ]], {i(1, "projcnt"), i(2, "title"), c(3, { --fix: hier})})),
}
