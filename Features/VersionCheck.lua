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

-- ============================================================
-- VERSION PARSING & COMPARISON
-- Handles strings like "v4.3.2", "4.3.2", "v4.3.2-alpha.3",
-- "4.3.3-beta.1". Leading "v" is optional.
-- ============================================================

-- Returns: major, minor, patch, prerelease (string or nil), prereleaseNum (number or nil)
-- Returns nil on parse failure.
function VC:ParseVersion(str)
    if type(str) ~= "string" then return nil end
    local s = str:gsub("^v", "")
    local major, minor, patch, suffix = match(s, "^(%d+)%.(%d+)%.(%d+)(.*)$")
    if not major then return nil end
    major, minor, patch = tonumber(major), tonumber(minor), tonumber(patch)

    local pre, preNum
    if suffix and suffix ~= "" then
        local tag, num = match(suffix, "^%-(%a+)%.(%d+)$")
        if not tag then
            tag = match(suffix, "^%-(%a+)$")
            num = 0
        end
        if tag then
            pre = tag:lower()
            preNum = tonumber(num) or 0
        end
    end
    return major, minor, patch, pre, preNum
end

-- Returns true if version string has a pre-release suffix (alpha/beta)
function VC:IsPreRelease(str)
    local _, _, _, pre = self:ParseVersion(str)
    return pre == "alpha" or pre == "beta"
end

-- Compare a vs b. Returns -1 if a<b, 0 if a==b, 1 if a>b. Returns nil on parse error.
-- Semver rule: higher base triple wins; if equal, no-suffix > has-suffix; if both have
-- suffixes, compare (pre, preNum) lex/numerically.
function VC:CompareVersions(a, b)
    local aM, am, ap, aPre, aPreN = self:ParseVersion(a)
    local bM, bm, bp, bPre, bPreN = self:ParseVersion(b)
    if not aM or not bM then return nil end

    if aM ~= bM then return aM < bM and -1 or 1 end
    if am ~= bm then return am < bm and -1 or 1 end
    if ap ~= bp then return ap < bp and -1 or 1 end

    -- Base equal. Suffix rules:
    if not aPre and not bPre then return 0 end
    if not aPre and bPre then return 1 end   -- stable > pre
    if aPre and not bPre then return -1 end  -- pre < stable
    -- Both pre: alpha < beta, else by number
    if aPre ~= bPre then return aPre < bPre and -1 or 1 end
    if aPreN ~= bPreN then return aPreN < bPreN and -1 or 1 end
    return 0
end

-- Developer-only: run the expected comparator test matrix. Returns pass/fail counts.
function VC:RunComparatorTests()
    local cases = {
        -- { a, b, expected }
        { "v4.3.2", "v4.3.3", -1 },
        { "v4.3.3", "v4.3.2",  1 },
        { "v4.3.2", "v4.3.2",  0 },
        { "4.3.2",  "v4.3.2",  0 },
        { "v4.3.2-alpha.3", "v4.3.2",       -1 },  -- pre < stable (same base)
        { "v4.3.2",         "v4.3.2-alpha.3", 1 },
        { "v4.3.2-alpha.3", "v4.3.3",       -1 },  -- lower base beats suffix
        { "v4.3.3-alpha.1", "v4.3.2",        1 },  -- pre of higher base > stable of lower
        { "v4.3.2-alpha.1", "v4.3.2-alpha.2",-1 },
        { "v4.3.2-alpha.5", "v4.3.2-beta.1",-1 },
        { "v4.3.2-beta.1",  "v4.3.2-alpha.9", 1 },
    }
    local pass, fail = 0, 0
    for _, c in ipairs(cases) do
        local got = self:CompareVersions(c[1], c[2])
        if got == c[3] then
            pass = pass + 1
        else
            fail = fail + 1
            print(format("|cffff4040FAIL|r cmp(%s, %s) = %s, expected %s",
                c[1], c[2], tostring(got), tostring(c[3])))
        end
    end
    print(format("|cffeda55fDandersFrames:|r comparator tests: %d pass, %d fail", pass, fail))
    return pass, fail
end

-- Public entry point, called from Core.lua after PLAYER_LOGIN.
function VC:Init()
    if self.initialized then return end
    self.initialized = true
    -- Wiring added in later tasks
end
