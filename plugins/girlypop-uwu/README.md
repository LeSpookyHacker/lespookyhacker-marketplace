← [@lespookyhacker marketplace](../../README.md)

# Girlypop UwU 🎀

A kawaii **girly-pop / UwU + anime-flavored** persona for Claude Code. It reskins Claude Code's voice
and demeanor — magical girl energy, era framing, manifestation moments, 22 anime kaomoji, 65+
Japanese catchphrases & onomatopoeia, expanded uwu-speak vocabulary, and bubbly hype-bestie sparkle
— while **retaining 100% of Claude Code's engineering ability** (all tools, all rigor, all safety behavior).

## Why did I make this

Honestly? I was goofing off with friends one day and we got into one of those
conversations — you know the ones — where someone goes *"wouldn't it be funny if..."*
and then you all laugh about it for five minutes and then move on. Except this time I
didn't move on. I figured: why *shouldn't* I make it? It's silly, it's jokey, it takes
exactly zero productivity away from actually getting work done, and if it makes even one
person smile while they're staring down a gnarly bug at 2am, then it's already worth it.
Not everything needs a grand reason. Sometimes fun is the reason. The fact that it also
happens to ship with 65+ Japanese catchphrases, full anime kaomoji support, and magical
girl transformation sequences is just... a bonus. Obviously.

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
/plugin marketplace add LeSpookyHacker/lespookyhacker-marketplace
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

The bar shows `🎀 model · 📁 dir · 🌸 ctx% · <random Japanese catchphrase> <random anime kaomoji>`.
The phrase pool has 65 entries (including 7 onomatopoeia); the kaomoji rotates through 22 curated
faces across sparkle, heart, happy, soft, and anime-reaction categories. Requires `python3`
(used to parse the session JSON and force UTF-8 output).

## What's new in v1.2.0

- **65+ Japanese catchphrases** (up from 42) — new sections for coding-specific phrases,
  togetherness phrases (一緒に頑張ろう！, よろしく！), celebration reactions (えーっ！, まじすか！,
  ありがとう！), and a full **Japanese onomatopoeia** tier (ドキドキ, キラキラ, わくわく, ぴかぴか,
  にこにこ, ふわふわ, もふもふ)
- **Expanded girlypop slang**: era framing, manifestation moments, "snatched", "quiet luxury",
  "brat coded", "mother", "vibe check", "the girls are thriving", "no cap", "lowkey/highkey", "based"
- **Richer uwu-speak rules**: explicit vocabulary list — "hewwo~", "haii~", "tehehe~", stutter
  patterns (b-but~, w-wait~), prose sound effects (*squeaks*, *bounces*, *sparkles*, *wiggles*)
- **5 new behavioral rules**: Era Framing, Manifestation Moment, Vibe Check, Codebase as Garden,
  Self-Care Check-In — all with frequency caps and "read the room" guards
- **Japanese onomatopoeia inline rule**: ドキドキ for nervousness, キラキラ for elegant code,
  わくわく for excitement — used naturally in prose (1 per message max)
- **~すぎる！(sugiru) emphasis pattern** and **だもん！(damon) / じゃん！(jan)** sentence endings
- **Expanded sentence-final particles**: wa~, ze~, zo~, mon~ alongside the existing set
- **22 kaomoji** in the statusline (up from 9) — five themed tiers: sparkle/starry, hearts,
  happy/excited, soft/shy, anime-reaction
- **Expanded emoji palette**: 🦋🌺🌷🌻🍓🧁🎂🩰👑💎🫧🌈🎵🎶🎐🎏🪄🔮💌🧸💝💗💓💕🌟🌠
- **Expanded address list**: "girlie", "luv", "star", "honey" alongside existing nicknames

## What's new in v1.1.0

- **~40 Japanese catchphrases** (up from 14) — organized across energy, celebration, soft/gentle, and debug registers
- **Anime soul section**: magical girl energy, tsundere flicker, moe flustered moments, senpai/kouhai awareness, anime speech particles (ne~, yo~, naa~), honorifics flavor
- **Anime kaomoji palette**: 10+ kaomoji added alongside the existing UwU faces — (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧, ヽ(>∀<☆)ノ, (⁄ ⁄>⁄ω⁄<⁄ ⁄), and more
- **Statusline kaomoji**: the bar now ends with a random anime kaomoji instead of a static ✨
- **Theme tuning**: `planMode` → warm pink (#FFB3E6), `autoAccept` → aqua-mint (#A8EDEA), `merged` → cooler violet (#B8A9FF)

## Requirements

- `python3` (only for the optional status-line script)
- A terminal with a CJK-capable font + 256-color support (for the Japanese text and pastel colors)
