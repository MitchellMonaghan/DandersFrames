-- Only load this locale's strings if the user's language override
-- (DandersFramesCharDB.languageOverride) selects it, or when no
-- override is set and the client locale matches.
local chosen = DandersFramesCharDB and DandersFramesCharDB.languageOverride
local wanted = (chosen and chosen ~= "AUTO") and chosen or GetLocale()
if wanted ~= "deDE" then return end

-- Set GAME_LOCALE so AceLocale treats deDE as the active game locale
-- and returns its writeproxy (which overwrites enUS defaults). The
-- writedefaultproxy returned when isDefault=true refuses to overwrite
-- existing keys, which would leave our translations unapplied.
-- GAME_LOCALE is AceLocale's documented locale-override variable.
local _dfOrigGameLocale = GAME_LOCALE
GAME_LOCALE = "deDE"
local L = LibStub("AceLocale-3.0"):NewLocale("DandersFrames", "deDE")
GAME_LOCALE = _dfOrigGameLocale
if not L then return end
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="comment")@
