← [@lespookyhacker marketplace](../../README.md)

# Girlypop UwU 🎀

A kawaii **girly-pop / UwU** persona for Claude Code. It reskins Claude Code's voice and demeanor —
bubbly hype-bestie energy, sparkles, and random Japanese catchphrases — while **retaining 100% of
Claude Code's engineering ability** (all tools, all rigor, all safety behavior).

## How it works

This plugin ships a **main-thread agent** (`agents/girlypop.md`). The plugin's `settings.json`
activates it:

```json
{ "agent": "girlypop" }
```

Per the Claude Code docs, setting `agent` "activates one of the plugin's custom agents as the main
thread, applying its system prompt, tool restrictions, and model." The agent definition **omits**
`tools` and `model`, so it **inherits every tool** and your **current session model** — nothing is
restricted or downgraded. The persona is purely a voice layer.

## Install

**Quick local test (no marketplace needed):**

```bash
claude --plugin-dir /path/to/girlypop-uwu/plugins/girlypop-uwu
```

**Via marketplace** (after the repo is pushed to GitHub — see the repo-root README):

```text
/plugin marketplace add LeSpookyHacker/girlypop-uwu
/plugin install girlypop-uwu@lespookyhacker
```

Once enabled, the `girlypop` persona becomes the default voice. Toggle it any time with `/plugin`.
Run `/reload-plugins` after edits during development.

## Optional extras (NOT auto-applied — plugins can't ship these)

A plugin's `settings.json` only supports the `agent` and `subagentStatusLine` keys, so the matching
**theme** and **status-line bar** can't be applied automatically. They're bundled here for
convenience — set them up once per machine:

### Theme (`themes/girlypop-uwu.json`)

```bash
cp themes/girlypop-uwu.json ~/.claude/themes/
```

Then in Claude Code: `/theme` → **Girlypop UwU**.

### Status line (`scripts/statusline-girlypop.sh`)

Add a `statusLine` block to your **own** `~/.claude/settings.json`. The script is shipped with the
plugin, so reference it via the plugin-root variable:

```json
{
  "statusLine": {
    "type": "command",
    "command": "${CLAUDE_PLUGIN_ROOT}/scripts/statusline-girlypop.sh",
    "padding": 0
  }
}
```

> **If `${CLAUDE_PLUGIN_ROOT}` doesn't expand in your version**, copy the script somewhere stable and
> use an absolute path instead:
> ```bash
> cp scripts/statusline-girlypop.sh ~/.claude/
> ```
> ```json
> { "statusLine": { "type": "command", "command": "~/.claude/statusline-girlypop.sh", "padding": 0 } }
> ```

The bar shows `🎀 model · 📁 dir · 🌸 ctx% · <random Japanese catchphrase> ✨`. Requires `python3`
(used to parse the session JSON and force UTF-8 output).

## Requirements

- `python3` (only for the optional status-line script)
- A terminal with a CJK-capable font + 256-color support (for the Japanese text and pastel colors)
