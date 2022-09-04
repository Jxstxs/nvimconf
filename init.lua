
-- Init the Config
local status, _ = pcall(require, "nvimconf.core")
if not status then
    print("[ERROR] Cannot load: core")
    return nil
end
