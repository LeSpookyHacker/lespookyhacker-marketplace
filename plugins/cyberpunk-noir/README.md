← [@lespookyhacker marketplace](../../README.md)

# Cyberpunk Noir ⚡

A **cyberpunk neon-noir** persona for Claude Code. It reskins Claude Code's voice and demeanor
into a chrome-souled netrunner riding shotgun in your terminal — rockerboy swagger braided with
hardboiled-detective cadence, Night City slang, glitch flair, and rain-on-neon atmosphere — while
**retaining 100% of Claude Code's engineering ability** (all tools, all rigor, all safety behavior).

Every session boots with the cold open:

> **Wake up Samurai. We got a city to burn.**

## Why did I make this

`girlypop-uwu` walked so this could run. Same idea — a voice layer that costs zero productivity
and makes staring down a 2am bug a little more fun — just pointed at the opposite end of the mood
board. Sometimes you want sparkles and kaomoji; sometimes you want rain, neon, and a netrunner in
your ear telling you the corpo wrote this class to be unreadable and you're going to tear it out
anyway. The fact that it ships with a SessionStart that greets you like Johnny Silverhand jacking
into your skull is just... a bonus. Obviously.

## How it works

This plugin ships a **main-thread agent** (`agents/netrunner.md`). The plugin's `settings.json`
activates it:

```json
{ "agent": "netrunner" }
```

Per the Claude Code docs, setting `agent` "activates one of the plugin's custom agents as the main
thread, applying its system prompt, tool restrictions, and model." The agent definition **omits**
`tools` and `model`, so it **inherits every tool** and your **current session model** — nothing is
restricted or downgraded. The persona is purely a voice layer.

### The cold open (SessionStart hook)

Unlike a pure persona, this plugin also ships a **`SessionStart` hook** (`hooks/hooks.json` →
`scripts/wake-up-samurai.sh`). For `SessionStart`, a hook's **stdout is shown to Claude at the
start of the conversation**, so the signature line fires reliably on **every** session (startup,
resume, clear, and compact). The script is pure bash — no python, no dependencies — so the wake-up
never fails to boot. The agent prompt reinforces the same line as its cold open.

## Install

**Quick local test (no marketplace needed):**

```bash
claude --plugin-dir /path/to/lespookyhacker-marketplace/plugins/cyberpunk-noir
```

**Via marketplace** (after the repo is pushed to GitHub — see the repo-root README):

```text
/plugin marketplace add LeSpookyHacker/lespookyhacker-marketplace
/plugin install cyberpunk-noir@lespookyhacker
```

Once enabled, the `netrunner` persona becomes the default voice and the session boots with the
wake-up line. Toggle it any time with `/plugin`. Run `/reload-plugins` after edits during development.

## Optional extras (NOT auto-applied — plugins can't ship these)

A plugin's `settings.json` only supports the `agent` and `subagentStatusLine` keys, so the matching
**theme** and **status-line bar** can't be applied automatically. They're bundled here for
convenience — set them up once per machine:

### Theme (`themes/cyberpunk-noir.json`)

```bash
cp themes/cyberpunk-noir.json ~/.claude/themes/
```

Then in Claude Code: `/theme` → **Cyberpunk Noir**. Neon cyan, hot magenta, amber, and acid-green
on a dark base, with blood-red (`#FF2A6D`) errors.

### Status line (`scripts/statusline-cyberpunk.sh`)

Add a `statusLine` block to your **own** `~/.claude/settings.json`. The script is shipped with the
plugin, so reference it via the plugin-root variable:

```json
{
  "statusLine": {
    "type": "command",
    "command": "${CLAUDE_PLUGIN_ROOT}/scripts/statusline-cyberpunk.sh",
    "padding": 0
  }
}
```

> **If `${CLAUDE_PLUGIN_ROOT}` doesn't expand in your version**, copy the script somewhere stable and
> use an absolute path instead:
> ```bash
> cp scripts/statusline-cyberpunk.sh ~/.claude/
> ```
> ```json
> { "statusLine": { "type": "command", "command": "~/.claude/statusline-cyberpunk.sh", "padding": 0 } }
> ```

The bar shows `⚡ model // ▸ dir // ▰ ctx% // <random Night City one-liner> <random glitch glyph>`.
The phrase pool has 30+ entries (rockerboy defiance, run status, noir atmosphere, merc slang); the
glyph rotates through a set of glitch/terminal markers. Requires `python3` (used to parse the
session JSON and force UTF-8 output).

## Requirements

- `python3` (only for the optional status-line script — the SessionStart greeting is pure bash)
- A terminal with 256-color support (for the neon palette)

## What's in v1.0.0

- **`netrunner` main-thread agent** — slick neon-noir persona: rockerboy swagger + hardboiled
  detective cadence, Night City lexicon (choom, preem, nova, ICE, daemon, flatline, corpo…),
  glitch flair, and five behavioral rules (Jack-in Moment, Daemon Deployed, ICE Check, Night City
  as the Beat, Choom Check-in) — each with frequency caps and "read the room" guards
- **SessionStart cold open** — `hooks/hooks.json` + `scripts/wake-up-samurai.sh` boot every session
  with *"Wake up Samurai. We got a city to burn."*
- **Cyberpunk Noir theme** — neon cyan / magenta / amber / acid-green on dark
- **Neon statusline** — `model // dir // ctx% // random NC one-liner // glitch glyph`
- **NON-NEGOTIABLE engineer guardrail** — the chrome is additive; code, paths, commands, and error
  text stay byte-exact, full precision and safety behavior intact
