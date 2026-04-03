local L = LibStub("AceLocale-3.0"):NewLocale("DandersFrames", "enUS", true)
if not L then return end

-- ============================================================
-- ENGLISH SOURCE STRINGS
-- This file serves as the development fallback AND the source
-- for CurseForge localization. At build time, the packager
-- replaces the @localization@ block below with all registered
-- strings from CurseForge.
--
-- To add a new localizable string:
-- 1. Add L["Your String"] = true below (alphabetically)
-- 2. Use L["Your String"] in the code
-- 3. CurseForge discovers it on next build
-- ============================================================

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="DandersFrames")@

-- Development fallback: these strings are used when running
-- from source (not a packaged build). Keep in sync with usage.
--@do-not-package@

L["1. Open ElvUI config with |cff1784d1/ec|r"] = true
L["2. Go to |cffffffffUnitFrames|r (left sidebar)"] = true
L["3. Click |cffffffffGeneral|r at the top"] = true
L["4. Scroll down to |cffffffffDisabled Blizzard Frames|r"] = true
L["5. Under |cffffffffGroup Units|r, uncheck |cffff6666Party|r and |cffff6666Raid|r"] = true
L["6. Click the reload button when prompted"] = true
L["Arena header will show using raid1-5 unit IDs"] = true
L["Arena mode |cff00ff00ENABLED|r for testing"] = true
L["Arena mode |cffff0000DISABLED|r"] = true
L["Aura timer not available"] = true
L["Auto profiles module not loaded."] = true
L["Cannot toggle arena mode during combat"] = true
L["Cast history not available"] = true
L["Click-casting conflict warning has been re-enabled."] = true
L["Click-casting database not loaded."] = true
L["Debug logging %s"] = true
L["Debug mode %s"] = true
L["disabled"] = true
L["Dispel debug not loaded"] = true
L["Drag any slider to see update function calls"] = true
L["enabled"] = true
L["Enter/leave combat to see role icon update logs"] = true
L["GUI not loaded yet."] = true
L["GUI reset to default size, scale, and position."] = true
L["Header debug %s"] = true
L["Header info not available"] = true
L["Join a raid group (2-5 players works best)"] = true
L["Picked setting: |cffffffff%s|r from tab |cffffffff%s|r"] = true
L["Popup module not loaded"] = true
L["Profiler not loaded"] = true
L["Raid debug not available"] = true
L["Recovered %d raid settings from interrupted auto layout editing session."] = true
L["Role icon debug %s"] = true
L["Slider update debug %s"] = true
L["Solo mode %s"] = true
L["Test mode ended — entering combat."] = true
L["The warning will appear on next reload if conflicts are detected."] = true
L["To fix the ElvUI compatibility issue:"] = true
L["Type /dfarena again to disable"] = true
L["Usage: /df importwizard <string>"] = true
L["Uses party frame settings/position"] = true
L["v%s loaded. Type |cffeda55f/df|r for settings, |cffeda55f/df resetgui|r if window is offscreen."] = true
L["WizardBuilder not loaded"] = true
L["Wizard '%s' saved!"] = true
L["|cff88ff88Green|r = lightweight update, |cffffff00Yellow|r = full update"] = true

--@end-do-not-package@
