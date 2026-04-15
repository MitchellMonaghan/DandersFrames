local addonName, DF = ...

DF.GUI = DF.GUI or {}

-- ============================================================
-- DF FONT OBJECT SYSTEM
-- ------------------------------------------------------------
-- Creates a DF-prefixed font object for every Blizzard GameFont*
-- template the addon's settings UI relies on. At load these are
-- exact copies of their Blizzard equivalents so the panel looks
-- identical. GUI:ApplySettingsFont() rewrites them using the
-- multi-alphabet family system in Config.lua, so a single user
-- setting re-skins the entire settings panel AND every FontString
-- inheriting from a DFFont automatically gains the roman/korean/
-- chinese/russian fallback family — fixing Cyrillic squares for
-- every widget that uses DFFont*.
-- ============================================================

-- Cache globals
local CreateFont = CreateFont
local _G = _G

local DEFAULT_FONT_SIZE = 10

-- The Blizzard templates the settings UI uses (see the font audit).
-- Order does not matter; this is just the source-of-truth list.
local TEMPLATES = {
    "GameFontHighlightSmall",        -- small white body text (most common)
    "GameFontHighlight",             -- white body text
    "GameFontNormal",                -- yellow header text
    "GameFontNormalSmall",           -- small yellow button text
    "GameFontNormalLarge",           -- large yellow title text
    "GameFontNormalHuge",            -- one-off oversized header
    "GameFontHighlightSmallOutline", -- small white with outline
    "GameFontDisableSmall",          -- greyed-out small hint text
    "GameFontDisable",               -- greyed-out normal hint text
}

-- Registry of DFFont objects (DFFont<suffix> = font object)
DF.DFFontObjects = DF.DFFontObjects or {}

-- Create one DFFont<Suffix> object per template, copying the
-- Blizzard template as-is. The per-template colour/size/outline
-- is preserved; only the font file can be swapped later.
local function CreateDFFontObjects()
    for _, templateName in ipairs(TEMPLATES) do
        local suffix = templateName:gsub("^Game", "")   -- "FontHighlightSmall" etc.
        local dfName = "DF" .. suffix                   -- "DFFontHighlightSmall"

        if not _G[dfName] then
            local blizzFont = _G[templateName]
            if blizzFont then
                local dfFont = CreateFont(dfName)
                dfFont:CopyFontObject(blizzFont)
                DF.DFFontObjects[dfName] = dfFont
            end
        else
            DF.DFFontObjects[dfName] = _G[dfName]
        end
    end
end

CreateDFFontObjects()

-- ============================================================
-- APPLY / REFRESH
-- Apply the user's chosen settings font to all DFFont objects,
-- and force visible settings FontStrings to re-render.
-- ============================================================

-- Apply the user's chosen settings font + outline to every DF
-- font object. Called once at load (after DB is ready) and on
-- any subsequent change via GUI:RefreshSettingsFont().
--
-- Implementation: for each DFFont object, read its current size
-- (from the Blizzard copy), then use CreateFontFamily via the
-- existing DF:SafeSetFont path so multi-alphabet fallbacks work.
-- We call SetFont directly on the DFFont object using the
-- resolved family path so inheritance propagates to all
-- FontStrings that use it.
function DF.GUI:ApplySettingsFont()
    if not DF.db then return end

    local fontName = DF.db.settingsFont or "Friz Quadrata TT"
    local outline  = DF.db.settingsFontOutline or ""
    if outline == "NONE" then outline = "" end

    local fontPath = DF:GetFontPath(fontName)
    -- Fallback to Blizzard's locale-aware font if LSM lookup fails
    if not fontPath then
        fontPath = "Fonts\\FRIZQT__.TTF"
    end

    for _, templateName in ipairs(TEMPLATES) do
        local suffix = templateName:gsub("^Game", "")
        local dfName = "DF" .. suffix
        local dfFont = DF.DFFontObjects[dfName]
        if dfFont then
            -- Preserve the template's existing size (different templates
            -- have different sizes — Small vs Normal vs Large).
            local _, size = dfFont:GetFont()
            size = size or DEFAULT_FONT_SIZE
            -- The user's outline choice is absolute: "None" means no outline
            -- on every DFFont, including templates that originally had an
            -- outline (e.g. GameFontHighlightSmallOutline). Users expect
            -- the dropdown to directly control the outline state.
            pcall(function()
                dfFont:SetFont(fontPath, size, outline)
            end)
        end
    end
end

-- Refresh every active FontString on every visible settings page
-- so changes appear instantly without /reload. Called from the
-- settings font/outline dropdowns' callbacks.
function DF.GUI:RefreshSettingsFont()
    self:ApplySettingsFont()

    -- Force FontStrings to re-evaluate their inherited font.
    -- Setting the same text back forces a layout pass.
    if self.Pages then
        for _, page in pairs(self.Pages) do
            if page.child then
                local function nudge(frame)
                    if not frame then return end
                    local objType = frame.GetObjectType and frame:GetObjectType()
                    if objType == "FontString" then
                        local t = frame:GetText()
                        if t and t ~= "" then
                            frame:SetText("")
                            frame:SetText(t)
                        end
                        return  -- FontStrings are leaf nodes; no children or sub-regions
                    end
                    -- Only Frames have GetChildren / GetRegions
                    if frame.GetChildren then
                        for _, child in ipairs({frame:GetChildren()}) do
                            nudge(child)
                        end
                    end
                    if frame.GetRegions then
                        for _, region in ipairs({frame:GetRegions()}) do
                            nudge(region)
                        end
                    end
                end
                nudge(page.child)
            end
        end
    end
end
