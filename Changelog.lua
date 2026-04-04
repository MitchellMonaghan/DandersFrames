local addonName, DF = ...
DF.BUILD_DATE = "2026-04-04T18:07:16Z"
DF.RELEASE_CHANNEL = "alpha"
DF.CHANGELOG_TEXT = [===[
# DandersFrames Changelog

## [4.2.0] - 2026-04-04

### New Features
* (Resource Bar) Add "Use Class Color" option for resource bars — colors power bars by class instead of power type (thanks **sKullsen**)
* (Localization) Add full localization infrastructure using AceLocale-3.0 and CurseForge translation system — community translators can now contribute translations via the CurseForge web UI without touching code
* (Localization) Add locale stubs for 11 languages: English, German, Spanish (EU/LATAM), French, Italian, Korean, Portuguese (BR), Russian, Chinese (Simplified/Traditional)

### Improvements
* (Frames) Add tooltip to resurrection icon showing cast status (green = incoming, yellow = pending accept)
* (Frames) Status icons (summon, AFK, phased, resurrection) now stay fully visible when unit is out of range or dead

### Bug Fixes
* (Raid Frames) Fix groups overlapping after auto-profile switch when layout direction and spacing are unchanged between profiles
* (Raid Frames) Fix CENTER-aligned groups landing in wrong positions when the first person joins a previously empty group
* (Fonts) Fix client crash (ACCESS_VIOLATION) when SetFontObject receives an uninitialized font family during early login
* (Auto Layouts) Fix frames using wrong positions or settings when switching between grouped and flat raid layouts
* (Auto Layouts) Fix double frame refresh when switching between auto-profiles
* (Auto Layouts) Fix race condition between auto-profile evaluation and roster update processing
* (Auto Layouts) Fix flat raid fast path not reapplying layout settings when spacing or anchors change
* (Auto Layouts) Fix grouped headers staying empty after switching from flat to grouped mode on instance entry
* (Auto Layouts) Fix raid container drifting to wrong position after group sorting due to CENTER anchor resize
* (Auto Layouts) Fix profile switch reading stale overlay settings during refresh
* (Auto Layouts) Fix flat raid container not resizing immediately after layout settings change
* (Auto Layouts) Add defensive refresh after auto-profile deactivation to prevent partially-configured frame state
* (Health Text) Fix Abbreviate (K/M) not working in Deficit mode outside of Test Mode (thanks **andybergon**)
* (Settings) Fix Health Bar section sync accidentally overwriting Health Text settings due to overly broad prefix matching
* (Resource Bar) Remove stale type guards that could prevent the resource bar from displaying power values
* (Missing Buffs) Fix missing buff indicators not fading when a unit is dead or offline
* (Aura Designer) Fix icon border appearing asymmetric at certain sizes by snapping to pixel boundaries
* (Aura Designer) Fix right panel sizing breaking when switching between Party and Raid mode on narrow windows
* (Aura Designer) Fix sound alert preview failing when "None" is selected or LSM returns a non-path value
* (Test Mode) Fix heal prediction animations showing inconsistent direction after importing a profile
* (Position Panel) Fix "Hide Drag Overlay" preference resetting every time the mover is unlocked
]===]
