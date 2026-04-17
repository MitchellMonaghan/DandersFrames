local addonName, DF = ...

-- ============================================================
-- VERSION CHECK & /df users
-- Broadcasts and receives DF version info over addon comms.
-- Nags the user once per session if a newer stable release is
-- seen. Powers /df users listing for group/raid.
-- ============================================================

local pairs, ipairs, type = pairs, ipairs, type
local tonumber, tostring = tonumber, tostring
local format, match, find, gsub = string.format, string.match, string.find, string.gsub
local GetTime = GetTime

DF.VersionCheck = DF.VersionCheck or {}
local VC = DF.VersionCheck

-- In-memory state (reset each session)
VC.seenUsers = {}       -- [playerFullName] = { version = "vX.Y.Z", lastSeen = GetTime() }
VC.hasNagged = false
VC.initialized = false

-- Constants
VC.PREFIX = "DandersFrames"
VC.STALE_SECONDS = 600

-- Public entry point, called from Core.lua after PLAYER_LOGIN.
function VC:Init()
    if self.initialized then return end
    self.initialized = true
    -- Wiring added in later tasks
end
