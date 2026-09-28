# Project Slayers 2 Script

A Roblox Studio Luau starter project for building and testing your own Project Slayers-inspired systems.

## Admin boss tools

For your own Roblox experience, bosses can be tagged with `Boss` using `CollectionService`.

- **U** — scan for tagged bosses within the configured radius.
- **Y** — server-side one-hit the nearest tagged boss.
- Edit `src/AdminBossConfig.lua` and replace the example UserId with your Roblox UserId.

The one-hit action is validated on the server and only configured admin UserIds can invoke it. This is intended for an experience you control, not for modifying someone else's live game.
