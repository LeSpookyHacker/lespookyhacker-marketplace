# LeSpookyHacker — Claude Code plugin marketplace

A personal [Claude Code plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces).
The marketplace manifest is at [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json);
plugins live under [`plugins/`](plugins/).

> The marketplace `name` is `lespookyhacker` — the handle users type after `@` when installing
> (e.g. `girlypop-uwu@lespookyhacker`). Change it in `.claude-plugin/marketplace.json` anytime.

## Plugins

| Plugin | Description |
|--------|-------------|
| [`girlypop-uwu`](plugins/girlypop-uwu) | Kawaii girly-pop / UwU persona — full engineering power, maximum sparkle 🎀 |

## Publish it

```bash
# from the repo root
git init
git add .
git commit -m "Add lespookyhacker marketplace + girlypop-uwu plugin"
gh repo create girlypop-uwu --public --source=. --push   # or push to a repo you made manually
```

## Use it (on any machine)

```text
/plugin marketplace add LeSpookyHacker/girlypop-uwu
/plugin install girlypop-uwu@lespookyhacker
```

- The first command registers this repo as a marketplace. **Relative-path plugin sources (used here)
  only resolve when the marketplace is added via git** (GitHub/GitLab/git URL), not via a direct URL
  to `marketplace.json`.
- Pull in marketplace updates later with `/plugin marketplace update lespookyhacker`.

## Develop / test locally (no marketplace)

```bash
claude --plugin-dir ./plugins/girlypop-uwu
```

Validate before publishing:

```bash
claude plugin validate ./plugins/girlypop-uwu
```
