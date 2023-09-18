return {
    s("row",
        fmt("| {} | {} | {} |", { i(1, "Attr"), i(2, "Desc"), i(3, "Values")})),
    s("xmlwiki", fmt([[
===== {} =====

<code xml>
{}
</code>

Ausgewählte Attribute sind:

^Attribut ^Beschreibung ^Werte ^
{}
    ]], { i(1),
        i(2, "code"), i(3, "rows") })),
}
