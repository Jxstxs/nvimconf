---@diagnostic disable: undefined-global, unused-local

local pvi = require("minimal.util").pvi

local function copy(
    args,
    parent,
    user_args
)
    return args[1][1]
end

return {
    s("argnullcheck", fmt("{}", { c(1, {
        fmt("{} ?? throw new ArgumentNullException(nameof({}));", { i(1, "toCheck"), f(copy, { 1 }, {}) }),
        fmt([[
        if ({})
            throw new ArgumentNullException(nameof({}));
        ]], { i(1, "toCheck"), i(2, "varToCheck") }),
    }) })),

    s("exceptionbubble", fmt([[

    using Microsoft.Extensions.Logging;
    using System;

    namespace {};
    internal class {} : I{}
    {{
        private readonly ILogger<{}> _Logger;
        {}

        public {}(
            ILogger<{}> logger{})
        {{
            _Logger = logger ?? throw new ArgumentNullException(nameof(logger));
            {}
        }}

        public {} {}({})
        {{
            {}

            try
            {{
                return {}Internal({});
            }}
            catch (Exception ex)
            {{
                _Logger.LogError($"Error while Executing '{{nameof({})}}'", ex);
                throw;
            }}
        }}

        private {} {}Internal({})
        {{
            {}
        }}
    }}
    ]], {
        i(1, "namespace"),
        i(2, "HandlerClassName"),
        f(copy, { 2 }, {}), -- IHandlerClassName
        f(copy, { 2 }, {}), -- ILogger<HandlerClassName>
        i(3, "// field definitions"),
        f(copy, { 2 }, {}), -- Ctor HandlerClassName
        f(copy, { 2 }, {}), -- ILogger<HandlerClassName> logger
        i(4, ""),           -- Ctor Params
        i(5, "// field initializers"),
        i(6, "HandlerReturnType"),
        i(7, "HandlerFunctionName"),
        i(8, "HandlerFunctionParams"),
        i(9, "// param checks"),
        f(copy, { 7 }, {}), -- HandlerFunctionNameInternal
        f(copy, { 8 }, {}), -- HandlerFunctionParams
        f(copy, { 7 }, {}), -- HandlerFunctionName Log Exception
        f(copy, { 6 }, {}), -- HandlerReturnTypeInternal
        f(copy, { 7 }, {}), -- HandlerFunctionNameInternal
        f(copy, { 8 }, {}), -- HandlerFunctionParams
        i(10, "throw new NotImplementedException();")
    })),

    s("property", fmt("{} {}{} {} {{ get; set; }}{}", {
        c(1, {
            t("public"),
            t("private"),
            t("internal"),
            t("protected"),
        }), -- accessModifier
        c(2, {
            t(""),
            t("readonly "),
            t("static "),
            i(1, "mod "),
        }), -- additionalModifier
        i(3, "PropertyType"),
        i(4, "PropertyName"),
        c(5, {
            t(""),
            fmt(" = {};", { i(1, "null!") }),
        }), -- defaultValue
    })),

    s("extensionclass", fmt([[

    namespace {};
    public static class {}Extension
    {{
        public static {} {}(this {} self{})
        {{
            {}
        }}
    }}
    ]], {
        i(1, "namespace"),
        i(2, "Class"),
        c(3, {
            f(copy, { 2 }, {}),
            i(1, "void"),
        }),                 -- ReturnType
        i(4, "ExtensionMethod"),
        f(copy, { 2 }, {}), -- ClassExtension
        c(5, {
            t(""),
            fmt(", {}", { i(1, "param") }),
        }), -- ExtraParameter
        c(6, {
            i(1, "// MethodBody"),
            sn(2, fmt([[
                {}

                        return self;
                ]], { i(1, "// MethodBody") })),
        }), -- MethodBody
    })),

    -- NOTE: maybe generics?
    s("classdef", fmt([[

    namespace {};
    {} {}{} {}{}
    {{
        {}
    }}
    ]], {
        i(1, "namespace"),
        c(2, {
            t("public"),
            t("internal"),
            t("private"),
        }), -- AccessModifier
        c(3, {
            t(""),
            t("static "),
            t("abstract "),
        }), -- AdditionalModifier
        c(4, {
            t("class"),
            t("record"),
            t("struct"),
        }), -- Type
        i(5, "Name"),
        c(6, {
            t(""),
            fmt(" : {}", {
                i(1, "InherritFrom"),
            }),
        }), -- Inherritence
        i(7, "// Body"),
    })),

    s("mapping", fmt([[
    .ForMember(dest => dest.{},
        opts => opts.MapFrom(src => src.{}))
    ]], { i(1, "dest"), i(2, "src") })),
}
