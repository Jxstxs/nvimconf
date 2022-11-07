local M = {}

--- Resources the plugins list and Syncs the Plugins
M.update_and_install = function()
    for name, _ in pairs(package.loaded) do
        if name:match "^nvimconf" and name ~= "nvimconf.modules.lsp.mason" and
            name ~= "nvimconf.modules.writing.autopairs" then
            package.loaded[name] = nil
        end
    end

    require("nvimconf.modules.plugins")
    require("packer").sync()
    dofile(vim.env.MYVIMRC)
    require("packer").compile()
end

return M
