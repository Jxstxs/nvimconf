return {
    s("fnc", fmt([[
    Function {}({}): {};
    {}
        {}
        Result := {};
    end
    ]], {
        i(1, "fnc"),
        i(2, "args"),
        i(3, "type"),
        c(4, {
            sn(1, fmt([[
            var
                {}
            Begin
            ]], {i(1)})),
            t("Begin")
        }),
        i(5), i(6)
    })),
    s("vdec", fmt("{}: {}{}", {i(1,"var"),i(2,"type"), c(3, {t(";"),t("")})})),
    s("vset", fmt("{} := {};", {i(1,"var"),i(2,"data")})),
    s("cset", fmt("{} := _{};", {i(1,"var"),r(1)})),
}
