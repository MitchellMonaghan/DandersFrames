-- Only load this locale's strings if the user's language override
-- (DandersFramesCharDB.languageOverride) selects it, or when no
-- override is set and the client locale matches. We pass isDefault=true
-- on NewLocale so AceLocale accepts the registration even when the
-- chosen locale differs from the WoW client locale.
local chosen = DandersFramesCharDB and DandersFramesCharDB.languageOverride
local wanted = (chosen and chosen ~= "AUTO") and chosen or GetLocale()
if wanted ~= "frFR" then return end

local L = LibStub("AceLocale-3.0"):NewLocale("DandersFrames", "frFR", true)
if not L then return end
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="comment")@
