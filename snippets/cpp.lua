---@diagnostic disable: undefined-global

local function copy(
    args,
    parent,
    user_args
)
    return args[1][1]
end

return {
    s("incguard", fmt([[
    #ifndef {}
    #define {}

    {}

    #endif // {}
    ]], { i(1, "FILE_H"), f(copy, { 1 }, {}), i(2, "code"), f(copy, { 1 }, {}) })),
}
