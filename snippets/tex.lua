---@diagnostic disable: unused-local, undefined-global

local texEnv = require("minimal.latex.env")

local function copy(
    args,
    parent,
    user_args
)
    return args[1][1]
end

local function table_to_snipobj(value_table, snipobj)
    local ret = {}
    for _, value in ipairs(value_table) do
        table.insert(ret, snipobj(value))
    end
    return ret
end

local function get_current_date()
    return os.date("%d. %B %Y")
end

return {
    s("docclass", fmt("\\documentclass{{{}}}", { i(1, "class") })),

    s("title", fmt("\\title{{{}}}", { i(1, "title") })),

    s("author", fmt("\\author{{{}}}", { c(1, {
        t(texEnv.name),
        i("Autor")
    }) })),

    s("mktitle", fmt("\\maketitle", {})),

    s("date", fmt("\\date{{{}}}", { c(1, {
        t(get_current_date()),
        i("date"),
    }) })),

    s("graphicx", fmt("\\usepackage{{graphicx}}", {})),

    s("image", fmt("\\includegraphic{{{}}}", {i(1, "file")})),

    s("minted", fmt("\\usepackage{{minted}}", {})),

    s("code", fmt("{}", {c(1, {
        sn("", fmt("\\mintinline{{{}}}{{{}}}", {i(1, "language"), i(2, "code")})),
        sn("", fmt([[
        \begin{{minted}}{{{}}}
        {}
        \end{{minted}}
        ]], {i(1, "language"), i(2, "code")})),
    })})),

    s("biber", fmt([[
    \usepackage[backend=biber,style={}]{{biblatex}}
    \addbibresource{{{}}}
    ]], { c(1, {
        t(texEnv.citation_style),
        i("style")
    }), c(2, {
        t("refs.bib"),
        i("file"),
    }) })),

    s("printrefs", fmt("\\printbibliography", {})),

    s("cite", fmt("\\{}{{{}}}", { c(1, table_to_snipobj(texEnv.citation_forms, t)), i(2, "to cite")})),

    s("begin", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { c(1, table_to_snipobj(texEnv.env_classes, t)), i(2, "Content"), f(copy, { 1 }) })),

    s("section", fmt("\\section{{{}}}", { i(1, "section") })),

    s("subsection", fmt("\\subsection{{{}}}", { i(1, "sub") })),

    s("bold", fmt("\\textbf{{{}}}", { i(1, "text") })),

    s("italic", fmt("\\textit{{{}}}", { i(1, "text") })),

    s("emphatic", fmt("\\emph{{{}}}", { i(1, "text") })),

    s("underline", fmt("\\underline{{{}}}", { i(1, "text") })),

    s("squote", fmt("`{}`", { i(1, "text") })),

    s("dquote", fmt("``{}``", { i(1, "text") })),

    s("list", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { c(1, table_to_snipobj(texEnv.env_lists, t)), i(2, "Content"), f(copy, { 1 }) })),

    s("item", fmt("\\item {}", { i(1, "item") })),

    s("label", fmt("\\label{{{}}}", { i(1, "lable") })),

    s("ref", fmt("\\ref{{{}}}", { i(1, "reference") })),

    s("style", fmt([[
    \begin{{{}}}
    {}
    \end{{{}}}
    ]], { c(1, table_to_snipobj(texEnv.env_styles, t)), i(2, "Content"), f(copy, { 1 }) })),
}
